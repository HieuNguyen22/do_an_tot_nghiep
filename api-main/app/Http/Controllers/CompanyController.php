<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateCompanyRequest;
use App\Http\Resources\Attendance\AttendanceResource;
use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\Department\DepartmentManager;
use App\Http\Resources\Department\DepartmentManagerResource;
use App\Http\Resources\Department\DepartmentResource;
use App\Http\Resources\Leave\LeaveResource;
use App\Http\Resources\Overtime\OvertimeResource;
use App\Http\Resources\Shift\ShiftResource;
use App\Http\Resources\User\BasicUserResource;
use App\Http\Services\CompanyService;
use App\Repositories\CompanyRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CompanyController extends Controller
{
    /**
     * @var Repository 
     */
    protected $companyRepository;

    /**
     * @var Service
     */
    protected $companyService;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->companyRepository = new CompanyRepository;
        $this->companyService = new CompanyService;
    }

    /**
     * register new Company & admin account for this company
     * 
     * @param \Illuminate\Http\Request $request
     * 
     */
    /**
     * Register new Company & admin account for this company
     * @OA\Post (
     *     path="/api/company/register",
     *     tags={"Company"},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                  @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="representative_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="address",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="category_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="latitude",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="longitude",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_check_login",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_work",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="max_distance",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="company_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="email",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="password",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                     "data_company":{
     *                          "name":"Tesla",
     *                          "representative_name":"Elon Musk",
     *                          "address":"Michigan",
     *                          "category_code":1,
     *                          "status_code":1,
     *                          "latitude":90,
     *                          "longitude":-90,
     *                          "type_check_login":2,
     *                          "type_work":2,
     *                          "max_distance":0.0129,
     *                          "company_code":1213255
     *                      },
     *                      "data_admin":{
     *                          "email":"admingoogle@gmail.com",
     *                          "password":123456789
     *                      }
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
    public function register(CreateCompanyRequest $request)
    {
        try {
            $companyInfo = $this->companyService->register($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new CompanyResource($companyInfo);
    }

    /**
     * Get all Company info
     * 
     * @param \Illuminate\Http\Request $request
     * @return \App\Http\Resources\Company\CompanyResource
     */
    /**
     * Get all company
     * 
     * @OA\Get (
     *     path="/api/company",
     *     tags={"Company"},
     *     security={{"bearer_token": {}}},
     *     @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *              example={"data" : {
     *                  "id": 103,
     *                  "name": "DevFast",
     *                  "representative_name": "Ngo Minh Kim",
     *                  "address": "Hanoi",
     *                  "category_code": 1,
     *                  "status_code": 1,
     *                  "latitude": 90,
     *                     "longitude": -90,
     *                     "type_check_login": 2,
     *                     "type_work": 2,
     *                     "max_distance": 0.0129,
     *                     "company": "1000000103",
     *                     "created_at": null
     *                      }
     *                }
     *          )
     *      ),
     *      @OA\Response(
     *          response=400,
     *          description="invalid",
     *          @OA\JsonContent(
     *              @OA\Property(property="msg", type="string", example="fail"),
     *          )
     *      )
     * )
     */
    public function index(Request $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();
        $companies = $this->companyRepository->search($params);
        return CompanyResource::collection($companies);
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - Company Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Get Detail Company
     * @OA\Get (
     *     path="/api/company/show/{id}",
     *     tags={"Company"},
     *     security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *                     example={"data" : 
     *                     {
     *                     "id": 103,
     *                     "name": "DevFast",
     *                     "representative_name": "Ngo Minh Kim",
     *                     "address": "Hanoi",
     *                     "category_code": 1,
     *                     "status_code": 1,
     *                     "latitude": 90,
     *                     "longitude": -90,
     *                     "type_check_login": 2,
     *                     "type_work": 2,
     *                     "max_distance": 0.0129,
     *                     "company": "1000000103",
     *                     "created_at": null
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function show($id)
    {
        try {
            $params['company_id'] = $id;
            $company = $this->companyRepository->findOrFail($id);
            $numberStaff = $this->companyService->numberStaff($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $company->number_staff = $numberStaff;
        return new CompanyResource($company);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id - Company Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Update Company
     * @OA\Put (
     *     path="/api/company/update/{id}",
     *     tags={"Company"},
     *     security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="representative_name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="category_code",
     *                          type="number"
     *                      ),   
     *                      @OA\Property(
     *                          property="address",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="latitude",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="longitude",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_check_login",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_work",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="max_distance",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
     *                     "name":"DevFast",
     *                      "representative_name":"Tung Lam",
     *                      "category_code":1,
     *                      "address":"Hanoi",
     *                      "status_code":1,
     *                      "latitude":90,
     *                      "longitude":-90,
     *                      "type_check_login":2,
     *                      "type_work":2,
     *                      "max_distance":0.0129
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
     *                     "id": 103,
     *                     "name": "DevFast",
     *                     "representative_name": "Ngo Minh Kim",
     *                     "address": "Hanoi",
     *                     "category_code": 1,
     *                     "status_code": 1,
     *                     "latitude": 90,
     *                     "longitude": -90,
     *                     "type_check_login": 2,
     *                     "type_work": 2,
     *                     "max_distance": 0.0129,
     *                     "company": "1000000103",
     *                     "created_at": null
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function update(Request $request, $id)
    {
        try {
            $company = $this->companyRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new CompanyResource($company);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id - Company Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Delete Company
     * @OA\Delete (
     *     path="/api/company/destroy/{id}",
     *     tags={"Company"},
     *     security={{"bearer_token": {}}},
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *             @OA\Property(property="msg", type="string", example="Delete shift success")
     *         )
     *     )
     * )
     */
    public function destroy($id)
    {
        try {
            $result = $this->companyRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response($result);
    }

    /**
     * Get list over time request by user's company
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function overtime(Request $request)
    {
        $params = $request->all();
        $result = $this->companyService->overtime($params);
        return OvertimeResource::collection($result);
    }

    /**
     * Get list leave request by user's company
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function leave(Request $request)
    {
        $params = $request->all();
        $result = $this->companyService->leave($params);
        return OvertimeResource::collection($result);
    }

    /**
     * Get List checkin late of user company today
     * 
     * @param \Illuminate\Http\Request $request
     * @return mixed
     */
    public function lateCheckin(Request $request)
    {
        $params = $request->all();
        $result = $this->companyService->listLateCheckin($params);
        return AttendanceResource::collection($result);
    }

    /**
     * Get all user unchecked today
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function unchecked(Request $request)
    {
        $params = $request->all();
        $result = $this->companyService->unchecked($params);
        return BasicUserResource::collection($result);
    }

    /**
     * Get info company by company_code
     * @param mixed $company_code
     * @return mixed
     */
    /**
     * Get info company by company_code
     * @OA\Get(
     *   tags={"Company"},
     *   path="api/company/getByCode/{company_code}",
     *     @OA\Parameter(
     *         in="path",
     *         name="company_code",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 103,
     *                     "name": "DevFast",
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function getByCode($company_code)
    {
        $data = $this->companyRepository->findByField('company_code', $company_code, ['id', 'name']);
        return response()->json(['data' => $data]);
    }

    /**
     * Get Manager Info by Company ID
     * @OA\Get(
     *   tags={"Company"},
     *   path="api/company/manager",
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" :             {
     *           "id": 44,
     *           "email": "thientai2@gmail.com",
     *           "company_id": 125,
     *           "employee_code": "14152389",
     *           "first_name": "Thien",
     *           "last_name": "Tai",
     *           "address": "qweqeqewqweqeqweqwe",
     *           "password": "$2y$10$I3Y.IOqBfcaZ7vrW9aoJ0e2aAHGeYeIeU0Q5A9Z15qVRMiF14K1Em",
     *           "status_code": null,
     *           "type_login": null,
     *           "type_work": null,
     *           "type_shift": null,
     *           "department_id": 1,
     *           "role_code": 1,
     *                                  }
     *                }
     *         )
     *      ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function getManagerCompany()
    {
        $params['company_id'] = Auth::guard('app-users')->user()->company_id;
        $user = $this->companyService->listManager($params);
        return DepartmentResource::collection($user);
    }

    /**
     * Summary of getDepartment
     * @param \Illuminate\Http\Request $request
     * @param mixed $id
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    /**
     * Get department of company by company id
     * @OA\Get(
     *   tags={"Company"},
     *   path="/api/company/department/{id}",
     *   security={{"bearer_token": {}}},
     *   @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *    @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" :             {
     *           "id": 44,
     *           "company_id": 125,
     *           "manager_id": 125,
     *           "name": "Dev",
     *           "status_code": null,
     *           "created_at": null,
     *           "updated_at": 1,
     *                                  }
     *                }
     *         )
     *      ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function getDepartment(Request $request, $id = null)
    {
        $params = $request->all();
        $params['company_id'] = !$id ? Auth::guard('app-users')->user()->company_id : $id;
        try {
            $result = $this->companyService->department($params);
        } catch (\Throwable $th) {
            throw $th;
        }
        return DepartmentResource::collection($result);
    }

    /**
     * Summary of getShift
     * @param \Illuminate\Http\Request $request
     * @param mixed $id
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    /**
     * Get shift of a company by company id
     * @OA\Get(
     *   tags={"Company"},
     *   path="/api/company/shift/{id}",
     *   security={{"bearer_token": {}}},
     *   @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *    @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" :             {
     *           "id": 44,
     *           "company_id": 125,
     *           "manager_id": 125,
     *           "name": "Dev",
     *           "status_code": null,
     *           "time_start": "08:00:00",
     *           "time_end": "17:30:00",
     *           "duration": null,
     *           "type":1,
     *           "created_at": null,
     *           "updated_at": 1,
     *                                  }
     *                }
     *         )
     *      ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function getShift(Request $request, $id = null)
    {
        $params = $request->all();
        $params['company_id'] = !$id ? Auth::guard('app-users')->user()->company_id : $id;
        try {
            $result = $this->companyService->shift($params);
        } catch (\Throwable $th) {
            throw $th;
        }
        return ShiftResource::collection($result);
    }

    /**
     * Summary of get employee
     * @param \Illuminate\Http\Request $request
     * @param mixed $id
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    /**
     * get all user of a company except admin
     * @OA\Get(
     *   tags={"Company"},
     *   path="/api/company/employee",
     *   security={{"bearer_token": {}}},
     *    @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" :             {
     *               "id": 2,
     *               "email": "hatunglam0@gmail.com",
     *               "company_id": 2,
     *               "employee_code": "103",
     *               "first_name": "Ha",
     *               "last_name": "hihihi",
     *               "address": "Cali",
     *               "phone_number": "0907456147",
     *               "status_code": 1,
     *               "type_login": 2,
     *               "type_work": 1,
     *               "type_shift": 1,
     *               "department_id": 2,
     *               "role_code": 1,
     *               "created_at": null,
     *               "updated_at": "2023-08-30T11:44:04.000000Z"
     *                                  }
     *                }
     *         )
     *      ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function employee(Request $request) {
        try {
            $company_id = Auth::guard('app-users')->user()->company_id;
            $params = $request->all();
            $params['company_id'] = $company_id;
            $users = $this->companyService->employee($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return BasicUserResource::collection($users);
    }
}