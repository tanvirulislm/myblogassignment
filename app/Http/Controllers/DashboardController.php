<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\Comment;
use App\Models\Bookmark;
use Illuminate\Http\Request;

class DashboardController extends Controller
{


    public function Dashboard(Request $request)
    {
        $userId = $request->header('id');


        $recentPosts = Post::where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get(['id', 'title']);


        $recentComments = Comment::with(['post' => function ($q) {
            $q->select('id', 'title');
        }])
            ->where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get(['id', 'content', 'post_id']);
        // dd($recentComments->toArray());

        $recentBookmarks = Bookmark::where('user_id', $userId)
            ->with('post:id,title')
            ->latest()
            ->get();

        $totalBookmarks = Bookmark::where('user_id', $userId)->count();

        // Totals
        $totalPosts = Post::where('user_id', $userId)->count();
        $totalComments = Comment::where('user_id', $userId)->count();

        return inertia('DashboardPage', [
            'user' => $userId,
            'recentPosts' => $recentPosts,
            'totalPosts' => $totalPosts,
            'totalComments' => $totalComments,
            'recentComments' => $recentComments,
            'recentBookmarks' => $recentBookmarks,
            'totalBookmarks' => $totalBookmarks,
        ]);
    }
}
