<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TagController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\BookmarkController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\NotificationController;
use App\Http\Middleware\TokenVerificationMiddleware;

// Route::get('/', function () {
//     return view('welcome');
// });


Route::get('/', [UserController::class, 'index']);


Route::post('/user-registration', [UserController::class, 'UserRegistration']);
Route::post('/user-login', [UserController::class, 'UserLogin']);
Route::post('/send-otp', [UserController::class, 'SendOTP']);
Route::post('/verify-otp', [UserController::class, 'VerifyOTP']);


// Pages All Route
Route::get('/user-register', [UserController::class, 'RegistrationPage']);
Route::get('/login', [UserController::class, 'Login']);


Route::post('/public-posts', [PostController::class, 'PublicPosts']);
Route::get('/public-posts', [PostController::class, 'PublicPosts']);
Route::get('/public-posts/{id}', [PostController::class, 'ShowSinglePost']);

Route::post('/posts/{postId}/comment-list', [CommentController::class, 'CommentList']);

// Tags Routes
Route::post('/tags', [TagController::class, 'GetTags']);


Route::middleware(TokenVerificationMiddleware::class)->group(function () {
    //All User Routes
    Route::get('/dashboard', [DashboardController::class, 'Dashboard']);
    Route::post('/user-logout', [UserController::class, 'UserLogout']);
    Route::post('/reset-password', [UserController::class, 'ResetPassword']);

    // All Page under the middleware
    Route::get('/profile', [UserController::class, 'ProfilePage']);
    Route::get('/reset-password', [UserController::class, 'ShowResetPasswordPage']);


    //All Post Routes
    Route::post('/create-post', [PostController::class, 'CreatePost']);
    Route::post('/post-list', [PostController::class, 'PostList']);
    Route::post('/post-by-id', [PostController::class, 'PostById']);
    Route::post('/update-post', [PostController::class, 'PostUpdate']);
    Route::post('/delete-post/{id}', [PostController::class, 'PostDelete']);

    // All page route
    Route::get('/create-post', [PostController::class, 'PostCreate']);
    // Route::get('/post-list', [PostController::class, 'PostList']);
    Route::get('/all-posts', [PostController::class, 'showAllPosts']);
    Route::get('/edit-post/{id}', [PostController::class, 'ShowEditPostPage']);



    //All tags routes
    Route::post('/create-tag', [TagController::class, 'CreateTag']);




    // All Comment Routes
    Route::post('/posts/{postId}/comments', [CommentController::class, 'CommentCreate']);
    // Route::post('/posts/{postId}/comment-list', [CommentController::class, 'CommentList']);
    Route::post('/comment/{commentId}', [CommentController::class, 'CommentUpdate']);
    Route::post('/comments/{commentId}', [CommentController::class, 'CommentDelete']);

    // All like route
    Route::post('/toggle-like', [LikeController::class, 'toggleLike']);
    Route::get('/like-count/{post_id}', [LikeController::class, 'likeCount']);
    Route::post('/check-like', [LikeController::class, 'checkLike']);

    // All Bookmark Route
    Route::post('/toggle-bookmark', [BookmarkController::class, 'toggleBookmark']);
    // Route::get('/my-bookmarks', [BookmarkController::class, 'showMyBookmarksPage']);
    Route::post('/check-bookmark', [BookmarkController::class, 'checkBookmark']);


    // All Notification Route
    Route::post('/send-notification', [NotificationController::class, 'sendNotification']);
    Route::get('/notifications', [NotificationController::class, 'getUserNotifications']);
    Route::post('/mark-as-read', [NotificationController::class, 'markAsRead']);
});
