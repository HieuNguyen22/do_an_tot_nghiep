<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Http\Services;

use App\Http\Resources\Attendance\AttendanceResource;
use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\Department\DepartmentResource;
use App\Repositories\AttendanceRepository;
use App\Repositories\CompanyRepository;
use App\Repositories\DepartmentRepository;
use App\Repositories\LeaveRepository;
use App\Repositories\OvertimeRepository;
use App\Repositories\ShiftRepository;
use App\Repositories\UsersRepository;
use App\Services\BaseService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class CompanyService extends BaseService
{
    /**
     * @var Repository
     */
    protected $companyRepository;
    protected $userRepository;
    protected $overtimeRepository;
    protected $leaveRepository;
    protected $shiftRepository;
    protected $attendanceRepository;
    protected $departmentRepository;
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->companyRepository = new CompanyRepository;
        $this->userRepository = new UsersRepository;
        $this->overtimeRepository = new OvertimeRepository;
        $this->attendanceRepository = new AttendanceRepository;
        $this->shiftRepository = new ShiftRepository;
        $this->departmentRepository = new DepartmentRepository;
        $this->leaveRepository = new LeaveRepository;
    }

    /**
     * Create company and admin of company
     * 
     * @param mixed $params
     * @return mixed
     */
    public function register($params)
    {
        do {
            $company_code = $this->generateCode();
            $isSet = $this->companyRepository->findByField('company_code', $company_code);
        } while ($isSet->first() != null);
        $params['company_code'] = $company_code;
        $user = $this->userRepository->create([
            "password" => Hash::make($params['password']),
            "email" => $params['email'],
            "role_code" =>3,
            "status_code" => 1,
            'first_name'=>$params['first_name'],
            'last_name'=>$params['last_name'],
            'employee_code' => $params['employee_code']

        ]);
        $companyData = $this->companyRepository->create([
            "name" => $params['name'],
            "representative_name" => $params['representative_name'],
            "address" => $params['address'],
            "category_code" => $params['category_code'],
            "status_code" => 1,
            "latitude" => $params['latitude'],
            "longitude" => $params['longitude'],
            "type_check_login" => $params['type_check_login'],
            "type_work" => $params['type_work'],
            "max_distance" => $params['max_distance'],
            "company_code" => $params['company_code'],
            "admin_id" => $user->id
        ]);
        $this->userRepository->update(['company_id' => $companyData->id], $user->id);
        try {
            $credentials = ["email" => $params['email'], "password" => $params['password']];
            if (!$token = Auth::guard('app-users')->attempt($credentials)) {
                return response()->json(['error' => 'invalid_credentials'], 400);
            }
        } catch (\Tymon\JWTAuth\Exceptions\JWTException $ex) {
            return response()->json(['error', 'could_not_create_token', 500]);
        }
        $companyData['token'] = $token;
        return $companyData;
    }

    /**
     * Get list overtime request by user's company
     * 
     * @param mixed $params
     * @return mixed
     */
    public function overtime($params)
    {
        $params['company_id'] = Auth::guard('app-users')->user()->company_id;
        return $this->overtimeRepository->search($params);
    }

    /**
     * Get list leave request by user's company
     * 
     * @param mixed $params
     * @return mixed
     */
    public function leave($params)
    {
        $params['company_id'] = Auth::guard('app-users')->user()->company_id;
        return $this->leaveRepository->search($params);
    }

    /**
     * Gen random Company code
     */
    public function generateCode()
    {
        $randDigit1 = $this->userRepository->generateRandomString(4);
        $randDigit2 = $this->userRepository->generateRandomString(4);
        $randString = $randDigit1 . "-" . $randDigit2;
        return $randString;
    }
    /**
     * Get list checkin late of user company today
     * @param mixed $params
     * @return array
     */
    public function listLateCheckin($params)
    {
        if (!isset($params['company_id'])) {
            $user = Auth::guard('app-users')->user();
            $params['company_id'] = $user->company_id;
        }
        if (!isset($params['time_checkin_start'])) {
            $params['time_checkin_start'] = Carbon::now()->startOfDay()->format('Y-m-d H:i:s');
        }
        if (!isset($params['time_checkin_end'])) {
            $params['time_checkin_end'] = Carbon::now()->endOfDay()->format('Y-m-d H:i:s');
        }
        $checkinToday = $this->attendanceRepository->search($params);
        $result = [];
        foreach ($checkinToday as $index => $checkin) {
            $time_checkin = Carbon::parse($checkin->time_checkin)->format('H:i:s');
            $time_start = $checkin->shift->time_start;
            if ($time_checkin > $time_start) {
                $result[] = $checkin;
            }

        }
        return $result;
    }

    /**
     * Get user unchecked to day
     * @param mixed $params
     * @return array
     */
    public function unchecked($params)
    {
        $result = [];
        $user_id_checked = [];
        $user = Auth::guard('app-users')->user();
        $params['company_id'] = $user->company_id;
        $company_employee = $this->userRepository->search($params);
        if (!isset($params['time_checkin_start'])) {
            $params['time_checkin_start'] = Carbon::now()->startOfDay()->format('Y-m-d H:i:s');
        }
        if (!isset($params['time_checkin_end'])) {
            $params['time_checkin_end'] = Carbon::now()->endOfDay()->format('Y-m-d H:i:s');
        }
        $checkinToday = $this->attendanceRepository->search($params);
        foreach (AttendanceResource::collection($checkinToday)->groupBy('user_id') as $key => $checkin) {
            $user_id_checked[] = $key;
        }
        $params = [
            'company_id' => $user->company_id,
        ];
        $result = $this->userRepository->search($params)->whereNotIn('id', [1, 2, 3]);
        // foreach ($company_employee as $key => $employee) {
        //     if (!collect($user_id_checked)->contains($employee->id)) {
        //         $result[] = $employee;
        //     }
        // }
        return $result;
    }

    /**
     * list manager by comapny id
     * @param mixed $params
     * @return array
     */
    public function listManager($params)
    {
        $managers = $this->departmentRepository->search($params);
        return $managers;
    }

    /**
     * Summary of numberStaff
     * @param mixed $params
     * @return int
     */
    public function numberStaff($params)
    {
        return $this->userRepository->count($params);
    }

    public function employee($params) {
        return $this->userRepository->search($params)->where('role_code', '<>', 3);
    }

    public function department($params)
    {
        try {
            $department = $this->departmentRepository->search($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return $department;
    }

    public function shift($params)
    {
        try {
            $result = $this->shiftRepository->search($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return $result;
    }
}