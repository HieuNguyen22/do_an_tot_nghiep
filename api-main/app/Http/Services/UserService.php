<?php

namespace App\Http\Services;

use App\Http\Resources\User\BasicUserResource;
use App\Repositories\CompanyRepository;
use App\Repositories\DepartmentRepository;
use App\Repositories\LeaveRepository;
use App\Repositories\OvertimeRepository;
use App\Repositories\UsersRepository;
use Exception;
use Illuminate\Support\Facades\Auth;

class UserService extends BaseService
{
    protected $overtimeRepository;
    protected $leaveRepository;
    protected $companyRepository;
    protected $departmentRepository;
    protected $userRepository;

    public function __construct()
    {
        $this->overtimeRepository = new OvertimeRepository;
        $this->leaveRepository = new LeaveRepository;
        $this->companyRepository = new CompanyRepository;
        $this->departmentRepository = new DepartmentRepository;
        $this->userRepository = new UsersRepository;
    }

    /**
     * get overtime by user_id
     * @param mixed $params
     * @return mixed
     */
    public function overtime($params)
    {
        $user = Auth::guard('app-users')->user();
        $params['user_id'] = $user->id;
        return $this->overtimeRepository->search($params);
    }

    /**
     * get leave by user id
     * @param mixed $params
     * @return mixed
     */
    public function leave($params)
    {
        $user = Auth::guard('app-users')->user();
        $params['user_id'] = $user->id;
        return $this->leaveRepository->search($params);
    }

    /**
     * get company by user id
     * @param mixed $params
     * @return mixed
     */
    public function company($params)
    {
        $user = Auth::guard('app-users')->user();
        $params['id'] = $user->company_id;
        return $this->companyRepository->findOrFail($user->company_id);
    }

    /**
     * get department by user id
     * @param mixed $params
     * @return mixed
     */
    public function department($params)
    {
        $user = Auth::guard('app-users')->user();
        $params['department_id'] = $user->department_id;
        return $this->departmentRepository->search($params);
    }

    /**
     * Admin update info for company by company id
     * @param mixed $dataUpdate
     * @param mixed $id
     * @throws \Exception
     * @return BasicUserResource
     */
    public function updateUserByAdmin($dataUpdate, $id){

        $user_id = Auth::guard('app-users')->user()->id;
        $params['id'] = Auth::guard('app-users')->user()->company_id;
        $admin_id = $this->companyRepository->search($params)->first()->admin_id;
        if ($user_id == $admin_id) {
            $user = $this->userRepository->update($dataUpdate, $id);
            return new BasicUserResource($user);
        } else {
            throw new Exception('Permission Denied !!!!');
        }
    }

    /**
     * update user when user join into company
     * @param mixed $params
     * @param mixed $user_id
     * @return mixed
     */
    public function joinIntoCompany($params, $user_id){
        $params['type_login'] = $this->companyRepository->findOrFail($params['company_id'])->type_check_login;
        $user = $this->userRepository->update($params, $user_id);
        return $user;
    }
}