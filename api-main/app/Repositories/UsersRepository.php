<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Repositories;

use App\Models\Log;
use App\Repositories\BaseRepository;
use App\Models\Users;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;
use Tymon\JWTAuth\Facades\JWTAuth;

class UsersRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [];
    protected $devicesRepository;
    protected $codeRepository;
    /**
     *
     */
    public function boot()
    {
    }


    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Users::class;
    }

    /**
     * Get data by multiple fields
     *
     * @param array $where
     * @param array $columns
     *
     * @return mixed
     */
    public function search($params)
    {
        $conditionsFormated = [];

        if (isset($params['id'])) {
            $conditionsFormated[] = ['id', '=', (int) $params['id']];
        }
        if (isset($params['email'])) {
            $conditionsFormated[] = ['email', 'like', '%' . $params['email'] . '%'];
        }
        if (isset($params['first_name'])) {
            $conditionsFormated[] = ['first_name', 'like', '%' . $params['first_name'] . '%'];
        }
        if (isset($params['last_name'])) {
            $conditionsFormated[] = ['last_name', 'like', '%' . $params['last_name'] . '%'];
        }
        if (isset($params['phone_number'])) {
            $conditionsFormated[] = ['phone_number', 'like', '%' . $params['phone_number'] . '%'];
        }
        if (isset($params['address'])) {
            $conditionsFormated[] = ['address', 'like', '%' . $params['address'] . '%'];
        }
        if (isset($params['employee_code'])) {
            $conditionsFormated[] = ['employee_code', 'like', '%' . $params['employee_code'] . '%'];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=', (int) $params['status_code']];
        }
        if (isset($params['type_login'])) {
            $conditionsFormated[] = ['type_login', '=', (int) $params['type_login']];
        }
        if (isset($params['type_work'])) {
            $conditionsFormated[] = ['type_work', '=', (int) $params['type_work']];
        }
        if (isset($params['type_shift'])) {
            $conditionsFormated[] = ['type_shift', '=', (int) $params['type_shift']];
        }
        if (isset($params['department_id'])) {
            $conditionsFormated[] = ['department_id', '=', (int) $params['department_id']];
        }
        if (isset($params['company_id'])) {
            $conditionsFormated[] = ['company_id', '=', (int) $params['company_id']];
        }
        if (isset($params['code'])) {
            $conditionsFormated[] = ['code', '=', (int) $params['code']];
        }
        if (isset($params['user_contains'])) {
            $conditionsFormated[] = ['id', 'in', [1, 2, 3]];
        }
        if (isset($params['created_at_start'])) {
            $conditionsFormated[] = ['created_at', '>=', $params['created_at_start']];
        }
        if (isset($params['created_at_end'])) {
            $conditionsFormated[] = ['created_at', '<=', $params['created_at_end']];
        }
        $params['conditions'] = $conditionsFormated;
        return $this->searchByParams($params);
    }

    /**
     * Get Total User
     * @param array $params
     * @return mixed
     */
    public function getTotalUser()
    {
        return count($this->model->get());
    }

    /**
     * Get Total Gold
     * @param array $params
     * @return mixed
     */
    public function getTotalGold()
    {
        return $this->model->sum('gold');
    }

    /**
     * Generate auto number
     *
     * @param integer $length
     * @return void
     */
    function generateRandomString($length = 6)
    {
        $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    /**
     * Create User Play
     *
     * @param array $params 
     * @return mixed
     */
    public function createUser(array $attributes, $deviceId, $gameType, $platform, $version, $agent, $timeZone)
    {
        $user = $this->model->where('device_id', '=', $deviceId)->first();
        if ($user == null) {
            $numRandom = $this->generateRandomString(4) . "-" . $this->generateRandomString(4);
            $attributes['user_name'] = 'ring-' . $numRandom;
            $attributes['device_id'] = $deviceId;
            $attributes['ref_code'] = $numRandom;
            $attributes['account_type'] = 'Guest';
            $attributes['game_type'] = $gameType;
            $attributes['level'] = 1;
            $attributes['platform'] = $platform;
            $attributes['version'] = $version;
            $attributes['agent'] = $agent;
            $attributes['time_zone'] = (int) $timeZone;
            $attributes['ip'] = Request()->ip();
            $user = parent::create($attributes);
            // new Devices
            $attributes = [];
            $attributes['user_id'] = $user['id'];
            $attributes['devices_id'] = $deviceId;
            $attributes['created_at'] = Carbon::now();
            $this->devicesRepository->newDevices($attributes);
            $user->bonus = 'RewardsForNewPlayer';
            return $user;
        } else {
            $updateUser = [];
            $updateUser['platform'] = $platform;
            $updateUser['version'] = $version;
            $updateUser['agent'] = $agent;
            $updateUser['game_type'] = $gameType;
            $updateUser['time_zone'] = (int) $timeZone;
            $user->update($updateUser);
            return $user;
        }
        return $user;
    }

    /**
     * Create User Play
     *
     * @param array $params 
     * @return mixed
     */
    public function userRegister($request)
    {
        try {
            $user = $this->model->where('phone_number', '=', $request['phone_number'])->first();
            if ($user == null) {
                //create new user
                $newUserAttribute = [];
                $newUserAttribute['user_name'] = $request['phone_number'];
                $newUserAttribute['password'] = md5($request['password']);
                $newUserAttribute['refresh_token'] = md5($request['phone_number'] . ($request['email'] != null ? $request['email'] : '') . config('contant.keySecret') . Carbon::now());
                $newUserAttribute['email'] = $request['email'];
                $newUserAttribute['full_name'] = $request['full_name'];
                $newUserAttribute['phone_number'] = $request['phone_number'];
                $newUserAttribute['age'] = $request['age'];
                $newUserAttribute['account_type'] = 'Guest';
                $newUserAttribute['ip'] = Request()->ip();

                $newUser = parent::create($newUserAttribute);
                //save to device table
                $newDeviceAttribute = [];
                $newDeviceAttribute['user_id'] = $newUser['id'];
                $newDeviceAttribute['device_id'] = $request['device_id'];
                $newDeviceAttribute['status'] = 1;
                $newDeviceAttribute['created_at'] = Carbon::now();

                $this->devicesRepository->newDevices($newDeviceAttribute);

                return $newUser;
            }
            throw new Exception("Phone number or deice id already used");
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    /**
     * User Login
     *
     * @param array $params 
     * @return mixed
     */
    public function userLogin($request)
    {
        try {
            $password = md5($request['password']);
            $user = $this->model->where('phone_number', '=', $request['phone_number'])->where('password', '=', $password)->first();
            if ($user != null) {
                $user['refresh_token'] = md5($request['phone_number'] . ($request['email'] != null ? $request['email'] : '') . config('contant.keySecret') . Carbon::now());
                $this->update($user->only('refresh_token'), $user['id']);
                return $user;
            }
            throw new Exception("Phone number or password incorrect");
        } catch (\Throwable $th) {
            throw $th;
        }

    }

    /**
     * Refresh Token
     *
     * @param array $params 
     * @return mixed
     */
    public function updateRefreshToken($request)
    {
        try {
            $user = $this->model->where('refresh_token', '=', $request['refresh_token'])->first();
            if ($user != null) {
                $user['refresh_token'] = md5($request['phone_number'] . ($request['email'] != null ? $request['email'] : '') . config('contant.keySecret') . Carbon::now());
                $this->update($user->only('refresh_token'), $user['id']);
                return $user;
            }
            throw new Exception("refresh_token incorrect");
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    /**
     * Get User by user id
     */
    public function getUserByUserId($userId)
    {
        return $this->model->where('id', '=', $userId)->first();
    }

    /**
     * Login
     *
     * @param [type] $deviceId
     * @return void
     */
    public function login($deviceId)
    {
        $user = $this->model->where('device_id', '=', $deviceId)->first();
        if ($user) {
            return $user;
        } else {
            return response()->json(['error' => $user->errors()], 400);
        }
    }

    /**
     *  Get Syn User Info
     *
     * @param [type] $userName
     * @param [type] $fullName
     * @param [type] $goldChange
     * @param [type] $levelChange
     * @return void
     */
    public function SynUserInfo($userName, $fullName, $goldChange, $levelChange)
    {
        try {
            $userId = Auth::user()->id;
            $user = Users::findOrFail($userId);
            if ($user == null) {
                Log::error('Don\'t have user by id');
                throw new Exception("Don\'t have user by id");
            } else
                $userUpdate = [];
            if (!empty($userName)) {
                $userUpdate['user_name'] = $userName;
            }

            if (!empty($fullName)) {
                $userUpdate['full_name'] = $fullName;
            }

            $userUpdate['gold'] = $user->gold + $goldChange;
            $userUpdate['level'] = $user->level + $levelChange;
            $user->update($userUpdate);

            return $user;
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    /**
     * Get game type
     *
     * @param [type] $user
     * @return void
     */
    public function gameTypes($userList)
    {
        $listUsers = $userList;
        for ($i = 0; $i < count($listUsers); $i++) {
            $user = $listUsers[$i];
            switch ($user['game_type']) {
                case 1:
                    $user['game_type_name'] = 'Free';
                    break;
                case 10:
                    $user['game_type_name'] = 'RemoveAdd';
                    break;
                case 11:
                    $user['game_type_name'] = 'BuyForLife';
                    break;
                case 12:
                    $user['game_type_name'] = 'Buy1Month';
                    break;
                case 13:
                    $user['game_type_name'] = 'Buy3Month';
                    break;
            }
            $listUsers[$i] = $user;
        }
        return $listUsers;
    }

    /**
     * Get List User by id list
     *
     * @param [type] $userIdList
     * @return void
     */
    public function getUserListByUserIdList($userIdList)
    {
        return $this->model->whereIn('id', $userIdList)->get(['id', 'gender_type', 'full_name', 'user_name', 'ref_code', 'level']);
    }

    /**
     * Get User By UserName
     *
     * @param [type] $userName
     * @return list
     */
    public function getUserByUserName($userName)
    {
        $user = $this->model
            ->where('user_name', '=', $userName)
            ->get();
        return $user;
    }

    /**
     * 
     * Get List User Limit 100
     * @return void
     */
    public function getListUser($friendIdList)
    {
        return $this->model->whereNotIn('id', $friendIdList)->get()->sortByDesc("id")->skip(0)->take(100);
    }


    /**
     * Total user Code
     *
     * @return void
     */
    public function getTotalUserCode()
    {
        return count($this->model->where('code_id')->get());
    }

    /**
     * Refresh Token
     *
     * @param array $params 
     * @return mixed
     */
    public function updateProfile($request)
    {
        try {
            $userId = Auth::user()->id;
            $user = $this->model->where('id', '=', $userId)->first();
            if ($user != null) {
                $user['updated_at'] = Carbon::now();
                $user['full_name'] = $request['full_name'];
                $user['age'] = $request['age'];
                $user['email'] = $request['email'];
                $this->update($user->only('full_name', 'age', 'email', 'updated_at'), $user['id']);
                return $user;
            }
            throw new Exception("User does not exist!");
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    /**
     * create user with number phone and active code
     *
     * @param array $request 
     * @return mixed
     */
    public function createUserWithNumberPhoneAndActiveCode($request)
    {
        try {
            $code = $this->codeRepository->where('id', $request['code_id'])->first();
            if ($code != null && $code->status == 0) {
                $user = $this->model->where('phone_number', '=', $request['phone_number'])->first();
                if ($user == null) {
                    //create new user
                    $numRandom = $this->generateRandomString(4) . "-" . $this->generateRandomString(4);
                    $newUserAttribute = [];
                    $newUserAttribute['user_name'] = $request['phone_number'];
                    $newUserAttribute['password'] = md5($request['phone_number']);
                    $newUserAttribute['refresh_token'] = md5($request['phone_number'] . config('contant.keySecret') . Carbon::now());
                    $newUserAttribute['phone_number'] = $request['phone_number'];
                    $newUserAttribute['ref_code'] = $numRandom;
                    $newUserAttribute['account_type'] = 'Guest';
                    $newUserAttribute['level'] = 1;
                    $newUserAttribute['ip'] = Request()->ip();

                    $newUser = parent::create($newUserAttribute);

                    // update code
                    $code['status'] = 1;
                    $code['updated_at'] = Carbon::now();
                    $this->codeRepository->update($code->only('status', 'updated_at'), $code['id']);

                    return $newUser;
                }
                throw new Exception("Phone number already used");
            }
            throw new Exception("Active code does not exist or already used!");
        } catch (\Throwable $th) {
            throw $th;
        }
    }

    /**
     * Summary of refreshJWTToken
     * @param mixed $token
     * @return \Illuminate\Http\JsonResponse|mixed|string
     */
    public function refreshJWTToken($token){
        try {
            JWTAuth::parseToken()->authenticate($token);
        } catch (TokenExpiredException $e) {
            try {
                $newToken = Auth::guard('app-users')->refresh(substr($token, 7));
            } catch (TokenInvalidException $e) {
                return response()->json(['error' => 'Token is invalid'], 401);
            } catch (\Exception $e) {
                return response()->json(['error' => 'Could not refresh token'], 500);
            }
        } catch (TokenInvalidException $e) {
            return response()->json(['error' => 'Token is invalid'], 401);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Token validation failed'], 400);
        }

        return  $newToken;
    }
}