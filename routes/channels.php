<?php

use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Log; // Optional: for debugging

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
|
| Here you may register all of the event broadcasting channels that your
| application supports. The given channel authorization callbacks are
| used to check if an authenticated user can listen to the channel.
|
*/

// This is the crucial part for your user notifications
Broadcast::channel('App.Models.User.{userId}', function ($user, $userId) {
    // $user is the currently authenticated Laravel user instance.
    // $userId is the value passed in the channel name (e.g., '123' from 'App.Models.User.123').

    // Log::info("Authorizing channel App.Models.User.{$userId} for user: " . ($user ? $user->id : 'Guest')); // Optional Debugging

    // The authorization logic:
    // Return true if the authenticated user's ID matches the requested channel ID.
    // Ensure you cast both to the same type (e.g., integer) for a reliable comparison.
    return (int) $user->id === (int) $userId;
});

// You might add other channels here later if needed for other features.
