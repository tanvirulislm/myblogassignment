<?php

namespace App\Http\Middleware;

use App\Models\User;
use Inertia\Middleware;
use App\Helper\JWTToken;
use Illuminate\Http\Request;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        $token = $request->cookie('token');
        $user = null;

        if ($token) {
            $result = JWTToken::VerifyToken($token);
            if ($result !== 'unauthorized') {
                $user = User::find($result->userId);
            }
        }

        return array_merge(parent::share($request), [
            'auth' => [
                'user' => $user,
            ],
        ]);
    }
}
