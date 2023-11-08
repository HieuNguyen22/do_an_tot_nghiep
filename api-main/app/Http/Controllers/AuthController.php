<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Repositories\AdminRepository;
use App\Http\Requests\Admins\AdminRequest;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Requests\Auth\ChangePasswordRequest;
use App\Http\Resources\Admins\Admin\AdminResource;

class AuthController extends Controller
{
    /**
     * @var Repository
     */
    protected $adminRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->adminRepository = new AdminRepository();
    }

    /**
     * Login by email and password.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function login(LoginRequest $request)
    {
        $credentials = $request->only('email', 'password');
        try {
            if (!$token = JWTAuth::attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $ex) {
            return response()->json(['error', 'could_not_create_token', 500]);
        }
        $admin = Auth::user();
        $admin->token = $token;
        $jsonAdmin = new AdminResource($admin);

        return $jsonAdmin;
    }

    /**
     * Register a account admin
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function register(AdminRequest $request)
    {
        $admin = $this->adminRepository->create($request->all());
        $token = JWTAuth::fromUser($admin);
        $admin->token = $token;
        $jsonAdmin = new AdminResource($admin);

        return $jsonAdmin;
    }

    /**
     * Logout
     * 
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function logout(Request $request)
    {
        try {
            JWTAuth::invalidate(JWTAuth::getToken());
            return response()->json(null, 204);
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $exception) {
            return response()->json([
                'status' => false,
                'message' => 'Sorry, the admin cannot be logged out'
            ], 200);
        }
    }

    /**
     * Change Password
     * 
     * @param ChangePasswordRequest $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    public function changePassword(ChangePasswordRequest $request, $id)
    {
        try {
            $admin = $this->adminRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonAdmin = new AdminResource($admin);

        return $jsonAdmin;
    }
}