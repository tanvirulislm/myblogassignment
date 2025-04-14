<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;

class NotificationController extends Controller
{
    // Send a notification
    public function sendNotification(Request $request)
    {
        $user_id = $request->input('user_id');
        $type = $request->input('type');
        $message = $request->input('message');

        if (!$user_id || !$type || !$message) {
            return response()->json([
                'status' => 'error',
                'message' => 'Missing required fields'
            ], 400);
        }

        // Create a notification
        $notification = Notification::create([
            'user_id' => $user_id,
            'type' => $type,
            'message' => $message,
        ]);

        // Broadcast the notification via Pusher
        event(new \App\Events\NewNotification($notification));

        return response()->json([
            'status' => 'success',
            'message' => 'Notification sent successfully'
        ]);
    }

    // Get all notifications for a user
    public function getUserNotifications(Request $request)
    {
        $user_id = $request->header('id');

        if (!$user_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'User ID missing'
            ], 400);
        }

        $notifications = Notification::where('user_id', $user_id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'status' => 'success',
            'notifications' => $notifications
        ]);
    }

    // Mark notifications as read
    public function markAsRead(Request $request)
    {
        $user_id = $request->header('id');
        $notification_id = $request->input('notification_id');

        if (!$user_id || !$notification_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'User ID or Notification ID missing'
            ], 400);
        }

        $notification = Notification::where('id', $notification_id)->where('user_id', $user_id)->first();

        if (!$notification) {
            return response()->json([
                'status' => 'error',
                'message' => 'Notification not found'
            ], 404);
        }

        $notification->update(['read_at' => now()]);

        return response()->json([
            'status' => 'success',
            'message' => 'Notification marked as read'
        ]);
    }
}
