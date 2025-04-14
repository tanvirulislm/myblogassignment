<?php

namespace App\Http\Controllers;

use App\Models\Like;
use App\Models\Post;
use Illuminate\Http\Request;

class LikeController extends Controller
{
    // Toggle like/unlike for a post
    public function toggleLike(Request $request)
    {
        $user_id = $request->header('id');
        $post_id = $request->input('post_id');

        if (!$user_id || !$post_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'User ID or Post ID missing'
            ], 400);
        }

        $post = Post::find($post_id);

        if (!$post) {
            return response()->json([
                'status' => 'error',
                'message' => 'Post not found'
            ], 404);
        }

        $existingLike = Like::where('user_id', $user_id)->where('post_id', $post_id)->first();

        if ($existingLike) {
            $existingLike->delete();
            $liked = false;
        } else {
            Like::create([
                'user_id' => $user_id,
                'post_id' => $post_id,
            ]);
            $liked = true;
        }

        // Get updated like count
        $likeCount = Like::where('post_id', $post_id)->count();

        return response()->json([
            'status' => 'success',
            'message' => $liked ? 'Post liked' : 'Post unliked',
            'like_count' => $likeCount
        ]);
    }

    // Get like count for a post
    public function likeCount($post_id)
    {
        $likeCount = Like::where('post_id', $post_id)->count();

        return response()->json([
            'status' => 'success',
            'like_count' => $likeCount
        ]);
    }

    // Check if a user has liked a post
    public function checkLike(Request $request)
    {
        $user_id = $request->header('id');
        $post_id = $request->input('post_id');

        $liked = Like::where('user_id', $user_id)->where('post_id', $post_id)->exists();

        return response()->json([
            'status' => 'success',
            'liked' => $liked
        ]);
    }
}
