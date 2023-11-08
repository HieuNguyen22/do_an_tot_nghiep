<?php

namespace App\Http\Controllers;

use App\Http\Resources\Department\DepartmentResource;
use App\Repositories\DepartmentRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DepartmentController extends Controller
{
    /**
     * @var Repository
     */
    protected $departmentRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->departmentRepository = new DepartmentRepository();
    }

    /**
     * Get all Department info
     * 
     * @param \Illuminate\Http\Request $request
     * @return \App\Http\Resources\Department\DepartmentResource
     */
    /**
     * Get all Department
     * 
     * @OA\Get (
     *     path="/api/department",
     *     tags={"Department"},
     *      security={{"bearer_token": {}}},
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *                 example={"data" : {
     *                     "id": 1,
     *                     "name": "Dev",
     *                     "company_id": 1,
     *                     "manager_id": 1,
     *                     "status_code": 1,
     *                                  }
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
        $departments = $this->departmentRepository->search($params);
        return DepartmentResource::collection($departments);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param \Illuminate\Http\Request $request
     * @return DepartmentResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Create Department
     * @OA\Post (
     *     path="/api/department/store",
     *     tags={"Department"},
     *     security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="company_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="name",
     *                          type="string"
     *                      ),   
     *                      @OA\Property(
     *                          property="manager_id",
     *                          type="number"
     *                      )
     *                      
     *                 ),
     *                 example={
     *                     "company_id":1,
     *                       "status_code":1,
     *                       "name":"IT",
     *                       "manager_id":3
     *                 
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *                     example={"data" : {
     *                     "id": 1,
     *                     "name": "Dev",
     *                     "company_id": 1,
     *                     "manager_id": 1,
     *                     "status_code": 1,
     *                                  }
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
    public function store(Request $request)
    {
        try {
            $department = $this->departmentRepository->create($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new DepartmentResource($department);
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - Department Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Get Detail Department
     * @OA\Get (
     *     path="/api/department/show/{id}",
     *     tags={"Department"},
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
     *                      "id": 1,
     *                     "name": "Dev",
     *                     "company_id": 1,
     *                     "manager_id": 1,
     *                     "status_code": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function show($id)
    {
        try {
            $department = $this->departmentRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new DepartmentResource($department);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id - Department Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Update Department
     * @OA\Put (
     *     path="/api/department/update/{id}",
     *     tags={"Department"},
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
     *                          property="manager_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),   
     *                    
     *                 ),
     *                 example={
     *                     "name": "Dev",
     *                     "manager_id": 1,
     *                     "status_code": 1,
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
     *                      "id": 1,
     *                     "name": "Dev",
     *                     "company_id": 1,
     *                     "manager_id": 1,
     *                     "status_code": 1,
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function update(Request $request, $id)
    {
        try {
            $department = $this->departmentRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new DepartmentResource($department);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id - Department Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Delete Department
     * @OA\Delete (
     *     path="/api/department/destroy/{id}",
     *     tags={"Department"},
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
            $result = $this->departmentRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data' => ['message' => 'Delete Successfully']], 200);
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - company Id
     * @return \Illuminate\Http\Response
     */
    /**
     * Get department by  Company id
     * @OA\Get (
     *     path="/api/department/company",
     *     tags={"Department"},
     *     security={{"bearer_token": {}}},
     *     @OA\Response(
     *         response=200,
     *         description="success",
     *         @OA\JsonContent(
     *                     example={"data" : 
     *                     {
     *                     "id": 1,
     *                     "name": "Dev",
     *                     "company_id": 1,
     *                     "manager_id": 1,
     *                     "status_code": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function getDepartmentsByCompanyId(Request $request, $id)
    {
        try {
            // $company_id = Auth::guard('app-users')->user()->company_id;
            $params['company_id'] = $id;
            $department = $this->departmentRepository->search($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return DepartmentResource::collection($department);
    }
}