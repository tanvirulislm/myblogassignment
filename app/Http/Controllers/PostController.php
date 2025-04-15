<?php

namespace App\Http\Controllers;

use App\Models\Tag;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class PostController extends Controller
{
    public function CreatePost(Request $request)
    {
        $user_id = $request->header('id');

        $request->validate([
            'title' => 'required',
            'content' => 'required',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp|max:2048',
            'visibility' => 'required|in:public,private',
            'tags' => 'nullable|array',
            'tags.*' => 'string|max:50', // tag name as string
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('uploads'), $imageName);
            $imagePath = 'uploads/' . $imageName;
        }

        $post = Post::create([
            'user_id' => $user_id,
            'title' => $request->title,
            'content' => $request->content,
            'image' => $imagePath,
            'visibility' => $request->visibility,
        ]);

        if ($request->has('tags')) {
            $tagIds = [];

            foreach ($request->tags as $tagName) {
                $tag = Tag::firstOrCreate(['name' => $tagName]);
                $tagIds[] = $tag->id;
            }

            $post->tags()->attach($tagIds);
        }

        return redirect('/dashboard')->with('success', 'Post created successfully!');
    }

    public function PostCreate()
    {
        return inertia("CreatePost");
    }


    public function showAllPosts(Request $request)
    {
        $userId = $request->header('id');


        $posts = Post::where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->get(['id', 'title', 'image', 'visibility']);

        return inertia('AllPostsPage', [
            'posts' => $posts
        ]);
    }

    public function PostById(Request $request)
    {
        $user_id = $request->header('id');

        $post = Post::where('id', $request->id)->where('user_id', $user_id)->first();

        return $post;
    }

    public function PostUpdate(Request $request)
    {
        $user_id = $request->header('id');
        $id = $request->input('id');

        // Validate basic fields
        $validatedData = $request->validate([
            'id' => 'required|integer',
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'visibility' => 'required|in:public,private',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp|max:2048',
            'tags' => 'nullable|array',
            'tags.*' => 'nullable|string|max:50',
        ]);

        $post = Post::where('id', $validatedData['id'])->where('user_id', $user_id)->first();

        if (!$post) {
            return redirect()->back()->withErrors(['message' => 'Post not found or unauthorized.']);
            // Or handle as appropriate for your app flow
            // return response()->json([
            //     'status' => 'error',
            //     'message' => 'Post not found or unauthorized'
            // ], 404);
        }

        // Handle Image Upload (if a new image is provided)
        if ($request->hasFile('image')) {
            // Delete old image if it exists
            if ($post->image && file_exists(public_path($post->image))) {
                try {
                    unlink(public_path($post->image));
                } catch (\Exception $e) {
                    Log::error("Failed to delete old image: " . $post->image . " Error: " . $e->getMessage());
                }
            }

            // Store new image
            $image = $request->file('image');
            $imageName = time() . '_' . uniqid() . '.' . $image->getClientOriginalExtension();
            $image->move(public_path('uploads'), $imageName);
            $post->image = 'uploads/' . $imageName;
        }

        // Update post fields (excluding image, handled above)
        $post->title = $validatedData['title'];
        $post->content = $validatedData['content'];
        $post->visibility = $validatedData['visibility'];
        $post->save();

        // --- Handle Tags ---
        $tagIds = [];
        if (!empty($validatedData['tags'])) {
            foreach ($validatedData['tags'] as $tagName) {
                $trimmedTagName = trim($tagName);
                if (!empty($trimmedTagName)) {
                    $tag = Tag::firstOrCreate(['name' => $trimmedTagName]);
                    $tagIds[] = $tag->id;
                }
            }
        }


        $post->tags()->sync($tagIds);

        $post->tags()->sync($tagIds);


        return redirect('/all-posts')->with('success', 'Post updated successfully!');
    }

    public function ShowEditPostPage($id, Request $request)
    {
        $userId = $request->header('id');

        $post = Post::with('tags')->where('id', $id)->where('user_id', $userId)->first();

        if (!$post) {
            return redirect('/dashboard')->withErrors(['message' => 'Post not found or unauthorized.']);
        }

        return inertia('EditPostPage', [
            'post' => $post,
        ]);
    }



    public function PostDelete(Request $request, $id)
    {
        $user_id = $request->header('id');

        if (!$user_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized: User ID missing'
            ], 401);
        }


        $post = Post::where('user_id', $user_id)->where('id', $id)->first();

        if (!$post) {
            return response()->json([
                'status' => 'error',
                'message' => 'Post not found or unauthorized'
            ], 404);
        }


        if (!empty($post->image) && file_exists(public_path($post->image))) {
            unlink(public_path($post->image));
        }


        $post->delete();

        return redirect('/all-posts')->with('success', 'Post deleted successfully.');
    }

    public function PublicPosts(Request $request)
    {
        $userId = $request->header('id');

        $postsQuery = Post::with('tags')
            ->where('visibility', 'public')
            ->orderBy('created_at', 'desc');


        if ($userId) {

            $postsQuery->withExists(['bookmarks as is_bookmarked' => function ($query) use ($userId) {
                $query->where('user_id', $userId);
            }]);
        } else {
            $postsQuery->selectRaw('*, 0 as is_bookmarked');
        }


        $posts = $postsQuery->paginate(6);
        $postsData = $posts->through(function ($post) use ($userId) {
            $post->is_bookmarked = (bool) $post->is_bookmarked;
            return $post;
        })->toArray();


        return inertia('PublicPostPage', [
            'posts' => [
                'data' => $postsData['data'],
                'links' => $posts->linkCollection()->toArray(),
                'current_page' => $posts->currentPage(),
                'last_page' => $posts->lastPage(),
                'from' => $posts->firstItem(),
                'to' => $posts->lastItem(),
                'total' => $posts->total(),
                'per_page' => $posts->perPage(),
            ]
        ]);
    }

    public function ShowSinglePost($id)
    {
        $post = Post::with('tags')->where('id', $id)->where('visibility', 'public')->firstOrFail();
        // dd($post);

        $post->tags_list = $post->tags->map(function ($tag) {
            return [
                'id' => $tag->id,
                'name' => $tag->name
            ];
        });

        return inertia('SinglePublicPostPage', [
            'post' => $post,
        ]);
    }
}
