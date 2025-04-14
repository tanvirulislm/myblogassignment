<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Bookmark;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class BookmarkController extends Controller
{
    public function toggleBookmark(Request $request)
    {

        $user_id = $request->header('id');

        if (!$user_id) {

            return response()->json([
                'status' => 'error',
                'message' => 'User ID not found in request headers. Authentication likely failed.'
            ], 401);
        }


        $post_id = $request->input('post_id');


        if (!$post_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'Post ID missing'
            ], 400);
        }


        $post = Post::find($post_id);
        if (!$post) {
            return response()->json([
                'status' => 'error',
                'message' => 'Post not found'
            ], 404);
        }

        try {

            $existingBookmark = Bookmark::where('user_id', $user_id)
                ->where('post_id', $post_id)
                ->first();

            if ($existingBookmark) {

                $existingBookmark->delete();
                $bookmarked = false;
                $message = 'Bookmark removed';
            } else {

                Bookmark::create([
                    'user_id' => $user_id,
                    'post_id' => $post_id
                ]);
                $bookmarked = true;
                $message = 'Post bookmarked';
            }


            return response()->json([
                'status' => 'success',
                'message' => $message,
                'bookmarked' => $bookmarked
            ]);
        } catch (\Exception $e) {

            Log::error("Error toggling bookmark for user {$user_id}, post {$post_id}: " . $e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Failed to process bookmark due to a server error.'
            ], 500);
        }
    }



    public function getBookmarkedPosts(Request $request)
    {

        $user_id = $request->header('id');

        if (!$user_id) {
            return response()->json(['status' => 'error', 'message' => 'User ID missing'], 400);
        }

        $bookmarkedPosts = Bookmark::where('user_id', $user_id)
            ->with('post:id,title,image')
            ->latest()
            ->get();

        return response()->json([
            'status' => 'success',
            'bookmarks' => $bookmarkedPosts
        ]);
    }
}
