<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Http\Controllers;

use Tymon\JWTAuth\Facades\JWTAuth;
use App\Repositories\UsersRepository;
use App\Http\Requests\UserRegisterRequest;
use App\Http\Requests\UserLoginRequest;
use App\Http\Requests\RefreshTokenRequest;
use App\Http\Resources\UserAuthenticate\UserAuthenticateResource;

class UserAuthenticateController extends Controller
{
    /**
     * @var Repository
     */
    protected $adminRepository;
    protected $usersRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->usersRepository = new UsersRepository();
    }

    /**
     * Login by email and password.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /**
     * @OA\Post(
     ** path="/api/users/userAuthenticate/userLogin",
     *   tags={"UserAuthenticate"},
     *   summary="User Login",
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="phone_number",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      ),
     *                 ),
     *                 example={
     *                     "phone_number": "string",
     *                     "password": "12345678"
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *      @OA\MediaType(
     *           mediaType="application/json",
     *      )
     *   ),
     *   @OA\Response(
     *      response=401,
     *       description="Unauthenticated"
     *   ),
     *   @OA\Response(
     *      response=400,
     *      description="Bad Request"
     *   ),
     *   @OA\Response(
     *      response=404,
     *      description="not found"
     *   ),
     *      @OA\Response(
     *          response=403,
     *          description="Forbidden"
     *      )
     *)
     **/
    public function userLogin(UserLoginRequest $request)
    {
        try {
            $userLogin = $this->usersRepository->userLogin($request);
            $token = JWTAuth::fromUser($userLogin);
            $jsonAuthenticate = [];
            $jsonAuthenticate['token'] = $token;
            $jsonAuthenticate['refreshToken'] = $userLogin['refresh_token'];
            $jsonAuthenticate['user'] = $userLogin;
            return new UserAuthenticateResource($jsonAuthenticate);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
    }

    /**
     * Register a account admin
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /**
     * @OA\Post(
     ** path="/api/users/userAuthenticate/userRegister",
     *   tags={"UserAuthenticate"},
     *   summary="User Register",
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="full_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="device_id",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="phone_number",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="age",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="email",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      ),
     *                 ),
     *                 example={
     *                     "full_name":"string",
     *                     "device_id":"string",
     *                     "phone_number":"string",
     *                     "age": 0,
     *                     "email": "example@gmail.com",
     *                     "password": "12345678"
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *      @OA\MediaType(
     *           mediaType="application/json",
     *      )
     *   ),
     *   @OA\Response(
     *      response=401,
     *       description="Unauthenticated"
     *   ),
     *   @OA\Response(
     *      response=400,
     *      description="Bad Request"
     *   ),
     *   @OA\Response(
     *      response=404,
     *      description="not found"
     *   ),
     *      @OA\Response(
     *          response=403,
     *          description="Forbidden"
     *      )
     *)
     **/
    public function userRegister(UserRegisterRequest $request)
    {
        
        try {
            $newUser = $this->usersRepository->userRegister($request);
            $token = JWTAuth::fromUser($newUser);
            $jsonAuthenticate = [];
            $jsonAuthenticate['token'] = $token;
            $jsonAuthenticate['refreshToken'] = $newUser['refresh_token'];
            $jsonAuthenticate['user'] = $newUser;
            return new UserAuthenticateResource($jsonAuthenticate);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
    }

    /**
     * @OA\Post(
     ** path="/api/users/userAuthenticate/refreshToken",
     *   tags={"UserAuthenticate"},
     *   summary="Refresh Token",
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="refresh_token",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "refresh_token": "string"
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *      @OA\MediaType(
     *           mediaType="application/json",
     *      )
     *   ),
     *   @OA\Response(
     *      response=401,
     *       description="Unauthenticated"
     *   ),
     *   @OA\Response(
     *      response=400,
     *      description="Bad Request"
     *   ),
     *   @OA\Response(
     *      response=404,
     *      description="not found"
     *   ),
     *      @OA\Response(
     *          response=403,
     *          description="Forbidden"
     *      )
     *)
     **/
    public function refreshToken(RefreshTokenRequest $request)
    {
        try {
            $user = $this->usersRepository->updateRefreshToken($request);
            $token = JWTAuth::fromUser($user);
            $jsonAuthenticate = [];
            $jsonAuthenticate['token'] = $token;
            $jsonAuthenticate['refreshToken'] = $user['refresh_token'];
            $jsonAuthenticate['user'] = $user;
            return new UserAuthenticateResource($jsonAuthenticate);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
    }
}
