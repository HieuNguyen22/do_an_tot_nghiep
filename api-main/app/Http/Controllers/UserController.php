<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Http\Controllers;

use App\Exceptions\CheckinException;
use App\Http\Requests\AttendanceRequest;
use App\Http\Requests\Auth\ChangePasswordRequest;
use App\Http\Requests\ForgetPasswordRequest;
use App\Http\Requests\UserLoginRequest;
use App\Http\Requests\UserRegisterRequest;
use App\Http\Resources\Admins\Users\UsersResource;
use App\Http\Resources\Attendance\AttendanceResource;
use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\Department\DepartmentResource;
use App\Http\Resources\Leave\LeaveResource;
use App\Http\Resources\Overtime\OvertimeResource;
use App\Http\Resources\User\BasicUserResource;
use App\Http\Resources\User\UserResource;
use App\Http\Services\BonusService;
use App\Http\Services\BuyActionService;
use App\Http\Services\CheckinService;
use App\Http\Services\UserService;
use App\Repositories\CompanyRepository;
use App\Repositories\UsersRepository;
use App\Http\Services\EventService;
use App\Mail\ResetPassword;
use App\Models\Users;
use App\Repositories\AttendanceRepository;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Throwable;
use Tymon\JWTAuth\Facades\JWTAuth;

class UserController extends Controller
{
    /**
     * @var Repository
     */
    protected $userRepository;
    protected $checkinService;
    protected $userService;
    protected $companyRepository;
    protected $attendanceRepository;
    /**
     * Construct
     */
    public function __construct()
    {
        $this->userRepository = new UsersRepository();
        $this->checkinService = new CheckinService();
        $this->userService = new UserService;
        $this->companyRepository = new CompanyRepository();
        $this->attendanceRepository = new AttendanceRepository();
    }

    /**
     * Login account user
     * 
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /**
     * @OA\POST(
     *   tags={"AuthUser"},
     *   path="/api/auth/login",
     *   summary="Login User",
     *   @OA\RequestBody(
     *       @OA\MediaType(
     *           mediaType="application/json",
     *           @OA\Schema(
     *               required={"email", "password"},
     *               @OA\Property(property="email", type="string"),
     *               @OA\Property(property="password", type="string")
     *           )
     *       )
     *   ),
     *   @OA\Response(response=200, description="OK",
     *   @OA\JsonContent(
     *       example={
     *           "data" : {
     *               "id": 17,
     *               "email": "dangvanhung2@gmail.com",
     *               "company_id": null,
     *               "code": "1415238",
     *               "first_name": "Dang",
     *               "last_name": "Hung",
     *               "address": null,
     *               "status_code": null,
     *               "type_login": null,
     *               "type_work": null,
     *               "type_shift": null,
     *               "department_id": null,
     *               "role_code": 1,
     *               "company_info": null,
     *               "token":"token"
     *           }
     *        }
     *   )),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */

    public function loginUser(UserLoginRequest $request)
    {
        try {
            $credentials = $request->only('email', 'password');
            if (!$token = Auth::guard('app-users')->attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $ex) {
            return response()->json(['error', 'could_not_create_token', 500]);
        }
        $user = Auth::guard('app-users')->user();
        // if ($user->status_code == config('contant.user_status.Inactive')) {
        //     return response()->json(['message' => 'Account has been blocked'], 422);
        // }
        $user->token = $token;
        return response()->json(['data' => $user], 200);
    }

    /**
     * Register a account user
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /**
     * Register User
     * @OA\Post (
     *     path="/api/auth/register",
     *     tags={"AuthUser"},
     *     security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="email",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="first_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="last_name",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "email": "hatunglam0@gmail.com",
     *                     "password": "123456789",
     *                      "first_name":"Dang",
     *                      "last_name":"Hung",
     *                      "code":"1415238"      
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      "company_info": null,
     *                      "token":"token"
     *                                  }
     *                }
     *         )
     *      ),
     * @OA\Response(
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
     * )
     */
    public function registerUser(UserRegisterRequest $request)
    {
        try {
            $passwordUnhash = $request->password;
            $request->merge(['password' => Hash::make($passwordUnhash), 'role_code' => 1, 'status_code' => 1]);
            $user = $this->userRepository->create($request->all());
            $credentials = [
                'email' => $request->email,
                'password' => $passwordUnhash
            ];

            if (!$token = Auth::guard('app-users')->attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $user->token = $token;
        return new UsersResource($user);
    }

    /**
     * Logout
     * 
     * @return \Illuminate\Http\JsonResponse
     * @throws \Illuminate\Validation\ValidationException
     */
    /**
     * Logout User
     * @OA\Post(
     *   tags={"AuthUser"},
     *   path="/api/auth/logout",
     *   security={{"bearer_token": {}}},
     *   @OA\Response(response=200, description="Sorry, cannot be logged out"),
     *   @OA\Response(response=204, description="Success"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function logout()
    {
        try {
            JWTAuth::invalidate(JWTAuth::getToken());
            auth()->logout();
            return response()->json(null, 204);
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $exception) {
            return response()->json([
                'status' => false,
                'message' => 'Sorry, cannot be logged out'
            ], 200);
        }
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - Company Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Get user by  Company id
     * @OA\Get (
     *     path="/api/company/user",
     *     tags={"Company"},
     *     security={{"bearer_token": {}}},
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *                     example={"data" : 
     *                     {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function getUsersByCompanyId()
    {
        try {
            $company_id = Auth::guard('app-users')->user()->company_id;
            $params['company_id'] = $company_id;
            $users = $this->userRepository->search($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return BasicUserResource::collection($users);
    }

    /**
     * get info user by user id
     * 
     * @return \App\Http\Resources\User\UserResource
     */
    /**
     * Get Detail user
     * @OA\Get (
     *     path="/api/user/show",
     *     tags={"User"},
     *     security={{"bearer_token": {}}},
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *                     example={"data" : 
     *                     {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function show()
    {
        try {
            $user_id = Auth::guard('app-users')->user()->id;
            $user = $this->userRepository->findOrFail($user_id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new UserResource($user);
    }

    /**
     * get info user by user id
     * 
     * @return \App\Http\Resources\User\UserResource
     */
    /**
     * Get Detail user
     * @OA\Get (
     *     path="/api/user/show/{id}",
     *     tags={"Admin"},
     *     security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *      ),
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *                     example={"data" : 
     *                     {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function showById($id)
    {
        try {
            $user = $this->userRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new UserResource($user);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    /**
     * Update User
     * @OA\Put (
     *     path="/api/user/update",
     *     tags={"User"},
     *     security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="first_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="last_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="address",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                                  
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function update(Request $request)
    {
        try {
            $user_id = Auth::guard('app-users')->user()->id;
            $user = $this->userRepository->update($request->all(), $user_id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new BasicUserResource($user);
    }

    /**
     * Get User Info
     * @OA\Get (
     *     path="/api/users/getUserInfo",
     *     tags={"Users"},
     *     security={{"bearer_token": {}}},
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *              example={"data": {
     *                             "id": 2,
     *                             "email": null,
     *                             "gold": 0,
     *                             "diamond": 0,
     *                             "avatar": null,
     *                             "gender_type": null,
     *                             "full_name": null,
     *                             "country": null,
     *                             "city": null,
     *                             "address": null,
     *                             "phone_number": null,
     *                             "zip_code": null,
     *                             "password": null,
     *                             "age": 0,
     *                             "device_id": "thuan2k",
     *                             "account_type": "Guest",
     *                             "user_name": "ring-UYTR-MRQU",
     *                             "ref_code": "UYTR-MRQU",
     *                             "parent_code": null,
     *                             "parent_id": 0,
     *                             "level": 0,
     *                             "platform": 0,
     *                             "version": 0,
     *                             "experience": 0,
     *                             "country_code": null,
     *                             "game_type": 0,
     *                             "ip": null,
     *                             "agent": null,
     *                             "status": 1,
     *                             "created_at": "2023-02-14T03:55:00.000000Z",
     *                             "updated_at": "2023-02-14T03:55:00.000000Z",
     *                             "token": null
     *                               }
     *                      }
     *         ),
     *     )
     * )
     */
    public function getUserInfo()
    {
        try {
            $user_id = Auth::guard('app-users')->user()->id;
            $user = $this->userRepository->findOrFail($user_id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonUser = new UsersResource($user);

        return $jsonUser;
    }

    /**
     * Get Syn User Info
     * @OA\Post (
     *     path="/api/users/synUserInfo?userName={userName}&fullName={fullName}&goldChange={goldChange}&levelChange={levelChange}",
     *     tags={"Users"},
     *     security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *         in="path",
     *         name="userName",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         in="path",
     *         name="fullName",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *      @OA\Parameter(
     *         in="path",
     *         name="goldChange",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *      @OA\Parameter(
     *         in="path",
     *         name="levelChange",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *              example={"data": {
     *                             "id": 2,
     *                             "email": null,
     *                             "gold": 20,
     *                             "diamond": 0,
     *                             "avatar": null,
     *                             "gender_type": null,
     *                             "full_name": null,
     *                             "country": null,
     *                             "city": null,
     *                             "address": null,
     *                             "phone_number": null,
     *                             "zip_code": null,
     *                             "password": null,
     *                             "age": 0,
     *                             "device_id": "thuan2k",
     *                             "account_type": null,
     *                             "user_name": "ring-UYTR-MRQU",
     *                             "ref_code": "UYTR-MRQU",
     *                             "parent_code": null,
     *                             "parent_id": 0,
     *                             "level": 0,
     *                             "platform": 0,
     *                             "version": 0,
     *                             "experience": 0,
     *                             "country_code": null,
     *                             "game_type": 0,
     *                             "ip": null,
     *                             "agent": null,
     *                             "status": 1,
     *                             "created_at": "2023-02-14T03:55:00.000000Z",
     *                             "updated_at": "2023-02-14T03:55:00.000000Z",
     *                             "token": null
     *                               }
     *                      }
     *         ),
     *     )
     * )
     */
    public function SynUserInfo(Request $request)
    {
        try {
            $userName = $request->input('userName');
            $fullName = $request->input('fullName');
            $goldChange = $request->input('goldChange');
            $levelChange = $request->input('levelChange');
            $checkSumIsOK = $this->checkSum($request, [$goldChange, $levelChange]);
            if ($checkSumIsOK) {
                $user = $this->userRepository->SynUserInfo($userName, $fullName, $goldChange, $levelChange);
            } else {
                throw new Exception("Security code is incorrect!");
            }
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new UsersResource($user);
    }

    /**
     * @OA\Put(
     ** path="/api/users/updateProfile",
     *   tags={"Users"},
     *   security={{"bearer_token": {}}},
     *   summary="Update Profile",
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
     *                          property="age",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="email",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "full_name": "string",
     *                     "age": 0,
     *                     "email": "string@gmail.com",
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
    public function updateProfile(Request $request)
    {
        try {
            $user = $this->userRepository->updateProfile($request);

            $jsonUpdateProfile = new UsersResource($user);
            return $jsonUpdateProfile;
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
    }
    /**
     * The user check-in for a shift
     * 
     * @param \Illuminate\Http\Request $request
     * @return AttendanceResource|\Illuminate\Http\JsonResponse|mixed
     *
     * @OA\POST(
     *     tags={"User"},
     *     path="/api/user/checkin",
     *     security={
     *         {"bearer_token": {}}
     *     },
     *     summary="Check-in for a shift",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             required={"shift_id"},
     *             @OA\Property(property="shift_id", type="integer")
     *         )
     *     ),
     *     @OA\Response(response=200, description="Successful check-in"),
     *     @OA\Response(response=401, description="Unauthorized"),
     *     @OA\Response(response=404, description="Not Found")
     * )
     */
    public function checkin(AttendanceRequest $request)
    {
        try {
            $shift_id = $request->input('shift_id');
            $result = $this->checkinService->checkin($request->all());
        } catch (CheckinException $ex) {
            return response()->json([
                'status_code' => 1,
                'message' => $ex->getMessage()
            ], 400);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new AttendanceResource($result);
    }

    /**
     * The user check-out for a shift
     * 
     * @return AttendanceResource|\Illuminate\Http\JsonResponse|mixed
     *
     * @OA\PUT(
     *     tags={"User"},
     *     path="/api/user/checkout",
     *     security={
     *         {"bearer_token": {}}
     *     },
     *     summary="Check-in for a shift",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="reason", type="string"),
     *             @OA\Property(property="duration", type="string"),
     *             @OA\Property(property="to_approve_id", type="integer"),
     *             example={
     *                     "reason": "traffic jam",
     *                     "duration": "04:00:00",
     *                     "to_approve_id": 1,
     *                 }
     *         )
     *     ),
     *     @OA\Response(response=200, description="Successful check-in"),
     *     @OA\Response(response=401, description="Unauthorized"),
     *     @OA\Response(response=404, description="Not Found")
     * )
     */
    public function checkout(Request $request)
    {
        $params = $request->all();
        try {
            $result = $this->checkinService->checkout($params);
        } catch (CheckinException $ex) {
            return response()->json([
                'Message' => $ex->getMessage()
            ], 400);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new AttendanceResource($result);
    }

    /**
     * Get user's last checkin
     * 
     * @return mixed
     */
    /**
     * Get user's last checkin
     *
     * @OA\Get(
     *     tags={"User"},
     *     path="/api/user/lastCheckin",
     *     security={
     *         {"bearer_token": {}}
     *     },
     *     @OA\Response(response=200, description="Successful check-in"),
     *     @OA\Response(response=401, description="Unauthorized"),
     *     @OA\Response(response=404, description="Not Found")
     * )
     */
    public function lastCheckin()
    {
        $last_checkin = $this->checkinService->lastCheckin();
        if (!$last_checkin) {
            return response()->json([
                'data' => ['errors' => "This account hasn't checkin"]
            ], 404);
        }
        return new AttendanceResource($this->checkinService->lastCheckin());
    }

    /**
     * User join into company
     * 
     * @param \Illuminate\Http\Request $request
     * @return UserResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * User join into company
     * @OA\Put(
     *   tags={"User"},
     *   path="/api/user/joinIntoCompany",
     *   security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="company_id",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
     *                     "company_id": 1213258,
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      "company_info": null,
     *                      "token":"token"
     *                                  }
     *                }
     *         )
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function joinIntoCompany(Request $request)
    {
        try {
            $user_id = Auth::guard('app-users')->user()->id;
            $params = $request->all();
            $user = $this->userService->joinIntoCompany($params, $user_id);
        } catch (Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new UserResource($user);
    }


    /**
     * Add user into company & department
     * 
     * @param \Illuminate\Http\Request $request
     * @return UserResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Admin add user into department
     * @OA\Put(
     *   tags={"User"},
     *   path="/api/user/addIntoDepartment",
     *   security={{"bearer_token": {}}},
     *   @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="user_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="department_id",
     *                          type="number"
     *                      ),
     *                 ),
     *                 example={
     *                     "company_id": 1213258,
     *                     "user_id": 2,
     *                     "department_id": 2,
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 17,
     *                      "email": "dangvanhung2@gmail.com",
     *                      "company_id": null,
     *                      "code": "1415238",
     *                      "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "address": null,
     *                      "status_code": null,
     *                      "type_login": null,
     *                      "type_work": null,
     *                      "type_shift": null,
     *                      "department_id": null,
     *                      "role_code": 1,
     *                      "company_info": null,
     *                      "token":"token"
     *                                  }
     *                }
     *         )
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function addIntoDepartment(Request $request)
    {
        try {
            $request->merge(['company_id' => Auth::guard('app-users')->user()->company_id]);
            $data = $request->all();
            $user = $this->userRepository->update($data, $data['user_id']);
        } catch (Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new BasicUserResource($user);
    }

    /**
     * @OA\PUT(
     *     tags={"User"},
     *     path="/api/user/lateCheckout",
     *     security={
     *         {"bearer_token": {}}
     *     },
     *     summary="Check-in for a shift",
     *      @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="reason",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_checkout",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="duration",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="to_approve_id",
     *                          type="number"
     *                      )
     *                 ),
     *             )
     *         )
     *      ),
     *     @OA\Response(response=200, description="Successful check-in"),
     *     @OA\Response(response=401, description="Unauthorized"),
     *     @OA\Response(response=404, description="Not Found")
     * )
     */
    public function lateCheckout(Request $request)
    {
        $params = $request->all();
        try {
            $result = $this->checkinService->lateCheckout($params);
        } catch (CheckinException $ex) {
            return response()->json([
                'status_code' => $this->lastCheckin()->status_code,
                'Message' => $ex->getMessage()
            ], 400);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new AttendanceResource($result);
    }

    /**
     * Change user password
     * 
     * @param \Illuminate\Http\Request $request
     * @return UserResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Change user password
     * @OA\Put(
     *   tags={"AuthUser"},
     *   path="/api/user/changePassword",
     *   security={{"bearer_token": {}}},
     *   @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="currentPassword",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="newConfirmPassword",
     *                          type="string"
     *                      ),
     *                 ),
     *                 example={
     *                     "currentPassword": "123456789",
     *                     "password": "987654321",
     *                     "newConfirmPassword": "987654321",

     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function changePassword(ChangePasswordRequest $request)
    {
        try {
            $user_id = Auth::guard('app-users')->user()->id;
            $data = $request->all();
            $data["password"] = Hash::make($data["password"]);
            $user = $this->userRepository->update($data, $user_id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new BasicUserResource($user);
    }

    public function changePasswordByUserId(Request $request)
    {
        try {
            $data = $request->all();
            $data["password"] = Hash::make($data["password"]);
            $user = $this->userRepository->update($data, $data['user_id']);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new BasicUserResource($user);
    }

    /**
     * Get overtime request by user
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function overtime(Request $request)
    {
        $params = $request->all();
        $result = $this->userService->overtime($params);
        return OvertimeResource::collection($result);
    }
    /**
     * Get leave request by user
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function leave(Request $request)
    {
        $params = $request->all();
        $result = $this->userService->leave($params);
        return LeaveResource::collection($result);
    }

    /**
     * Get user company
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function company(Request $request)
    {
        $params = $request->all();
        $result = $this->userService->company($params);
        return new CompanyResource($result);
    }

    /**
     * Get user Department
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function department(Request $request)
    {
        $params = $request->all();
        $result = $this->userService->department($params);
        return DepartmentResource::collection($result);
    }

    /**
     * Summary of getAllUser
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    /**
     * Get all user
     * @OA\Get(
     *   tags={"Admin"},
     *   path="/api/admins/user",
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function getAllUser(Request $request)
    {
        $params = $request->all();
        $result = $this->userRepository->search($params);
        return BasicUserResource::collection($result);
    }

    /**
     * Summary of updateUserByAdmin
     * @param \Illuminate\Http\Request $request
     * @param mixed $id
     * @return BasicUserResource
     */
    /**
     * Admin update user by user id
     * @OA\Get(
     *   tags={"User"},
     *   path="/api/admins/user/update/{id}",
     *   security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="first_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="last_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="role_code",
     *                          type="number"
     *                      ),
     *                 ),
     *                 example={
     *                     "first_name": "Dang",
     *                      "last_name": "Hung",
     *                      "role_code": 2,
     *                                  
     *                }
     *             )
     *         )
     *      ),
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function updateUserByAdmin(Request $request, $id)
    {
        $dataUpdate = $request->all();
        return $this->userService->updateUserByAdmin($dataUpdate, $id);
    }

    /**
     * Summary of updateUserByAdmin
     * @param \Illuminate\Http\Request $request
     * @param mixed $id
     * @return BasicUserResource
     */
    /**
     * Admin update user by user id
     * @OA\Get(
     *   tags={"User"},
     *   path="/api/refresh-token",
     *   security={{"bearer_token": {}}},
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function refreshToken(){
        $token = request()->headers->get('Authorization');
        $newToken = $this->userRepository->refreshJWTToken($token);
        return response()->json([
            'data'=>['refreshToken'=>$newToken]
        ]);
    }

    /**
     * Summary of forgotPassword
     * @param \App\Http\Requests\ForgetPasswordRequest $request
     * @return \Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Forgot password
     * @OA\Get(
     *   tags={"User"},
     *   path="/api/user/changePasswordByUserId",
     *   security={{"bearer_token": {}}},
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function forgotPassword(ForgetPasswordRequest $request)
    {
        $email = $request->input('email') ?? '';
        $user = $this->userRepository->findByField('email', $email)->first();
        $password = $this->userRepository->generateRandomString(8);
        $data["password"] = Hash::make($password);
        $user = $this->userRepository->update($data, $user->id);
        Mail::to($email)->send(new ResetPassword(
            [
                "name" => $user->first_name . ' ' . $user->last_name,
                "email" => $email,
                "password" => $password
            ]
        ));
        return response()->json([
            'data' => ['code' => 200, 'name' => $user->first_name . ' ' . $user->last_name],
        ]);;
    }
}