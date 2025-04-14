<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\User;
use App\Helper\JWTToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index()
    {
        //inertia render
        return inertia('HomePage');
    }

    public function RegistrationPage()
    {
        return inertia('RegisterPage');
    }


    public function UserRegistration(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required|unique:users,username',
                'email' => 'required|email|unique:users,email',
                'password' => 'required',
                'profile_photo' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg,webp|max:2048',
            ]);

            User::create([
                'username' => $request->input('username'),
                'email' => $request->input('email'),
                'password' => $request->input('password'),
                'profile_photo' => $request->input('profile_photo'),
            ]);

            return redirect('/login')->with('success', 'User registered successfully');
        } catch (Exception $e) {
            return redirect('/user-registration')->withErrors(['message' => $e->getMessage()]);
        }
    }

    public function Login()
    {
        return inertia('LoginPage');
    }

    public function UserLogin(Request $request)
    {
        $count = User::where('email', $request->input('email'))->where('password', $request->input('password'))->select('id')->first();

        if ($count !== null) {
            // User login -> JWT token issue
            $token = JWTToken::CreateToken($request->input('email'), $count->id);

            return redirect('/dashboard')->withCookie(cookie('token', $token, 60 * 24 * 30));
        } else {
            return back()->withErrors(['message' => 'Invalid credentials!']);
        }
    }


    public function UserLogout(Request $request)
    {
        return redirect('/login')->withCookie(cookie('token', '', -1));
    }

    public function SendOTP(Request $request)
    {
        $email = $request->input('email');
        $otp = rand(1000, 9999);

        $count = User::where('email', $email)->count();

        if ($count == 1) {
            // Mail::to($email)->send(new OTPMail($otp));
            User::where('email', $email)->update(['otp' => $otp]);
            return response()->json([
                'status' => 'success',
                'message' => "4 digit {$otp} OTP sent successfully"
            ], 200);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'unauthorized'
            ], 200);
        }
    }

    public function VerifyOTP(Request $request)
    {
        $email = $request->input('email');
        $otp = $request->input('otp');

        $count = User::where('email', $email)->where('otp', $otp)->count();

        if ($count == 1) {
            User::where('email', $email)->update(['otp' => 0]);
            $token = JWTToken::CreateTokenForSetPassword($request->input('email'));
            return response()->json([
                'status' => 'success',
                'message' => 'OTP verified successfully'
            ], 200)->cookie('token', $token, 60 * 24 * 30);
        } else {
            return response()->json([
                'status' => 'failed',
                'message' => 'OTP verification failed'
            ], 200);
        }
    }

    public function ProfilePage(Request $request)
    {
        $userId = $request->header('id');

        $user = User::find($userId);

        if (!$user) {
            return redirect('/login')->withErrors(['message' => 'User not found.']);
        }

        return inertia('ProfilePage', ['user' => $user]);
    }



    public function ResetPassword(Request $request)
    {
        try {
            $email = $request->header('email');
            $password = $request->input('password');
            User::where('email', $email)->update(['password' => $password]);
            return redirect('/login')->with('success', 'Password reset successfully');
        } catch (Exception $e) {
            return response()->json([
                'status' => 'failed',
                'message' => $e->getMessage()
            ]);
        }
    }

    public function ShowResetPasswordPage(Request $request)
    {
        // Get the user email from the token (set in middleware)
        $email = $request->header('email');

        // You can also fetch the user if needed
        $user = User::where('email', $email)->first();

        // Return the reset password page with user details (email in this case)
        return inertia('ResetPassword', ['user' => $user]);
    }
}
