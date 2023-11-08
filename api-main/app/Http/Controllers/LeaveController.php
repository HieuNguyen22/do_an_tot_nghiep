<?php

namespace App\Http\Controllers;

use App\Http\Requests\LeaveRequest;
use App\Http\Resources\Leave\LeaveResource;
use App\Repositories\LeaveRepository;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LeaveController extends Controller
{
    /**
     * @var Repository
     */
    protected $leaveRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->leaveRepository = new LeaveRepository();
    }

    /**
     * Get data by multiple fields.
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    /**
     * Get Leave
     * 
     * @OA\Get (
     *     path="/api/leave",
     *     tags={"Leave"},
     *      security={{"bearer_token": {}}},
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *                 example={"data" : {
     *                      "id": 1,
     *                       "created_at": null,
     *                       "updated_at": null,
     *                       "user_id": 2,
     *                       "company_id": 1,
     *                       "to_approve_id": 1,
     *                       "approve_id": null,
     *                       "time_start": "2023-08-15 14:28:44",
     *                       "time_end": "2023-11-30 13:00:00",
     *                       "duration": "04:05:00",
     *                       "month": null,
     *                       "status_code": 2,
     *                       "type": 1,
     *                       "reason": null,
     *                       "reason_reject": null
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
        $leaves = $this->leaveRepository->search($params);
        return LeaveResource::collection($leaves);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param \App\Http\Requests\LeaveRequest $request
     * @return LeaveResource
     * 
     * @OA\Post (
     *     path="/api/leave/store",
     *     tags={"Leave"},
     *     security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="user_id ",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="company_id ",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="to_approve_id ",
     *                          type="string"
     *                      ),   
     *                      @OA\Property(
     *                          property="approve_id ",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="time_start",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="time_end",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="duration",
     *                          type="number"
     *                      ),     
     *                      @OA\Property(
     *                          property="month",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),     
     *                      @OA\Property(
     *                          property="type",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="reason",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="reason_reject",
     *                          type="number"
     *                      ),
     *                 ),
     *                 example={
     *                     "company_id": 1,
     *                     "user_id": 2,
     *                     "time_start": "2023-11-08 08:00:00",
     *                     "to_approve_id": 1,
     *                     "duration": "04:00:00",
     *                     "status_code": 1,
     *                     "type": 1
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
     *                      "company_id": 1,
     *                      "user_id": 2,
     *                      "to_approve_id": 1,
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "duration": "04:05:00",
     *                      "status_code": 1,
     *                      "type": 2,
     *                      "updated_at": "2023-08-22T03:13:38.000000Z",
     *                      "created_at": "2023-08-22T03:13:38.000000Z",
     *                      "id": 11
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
    public function store(LeaveRequest $request)
    {
        try {
            $user = Auth::guard('app-users')->user();
            $request->merge(['user_id' => $user->id]);
            $request->merge(['company_id' => $user->company_id]);
            $request->merge(['month' => Carbon::parse($request->time_start)->month]);
            $result = $this->leaveRepository->create($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new LeaveResource($result);
    }

    /**
     * Get Object By Id.
     * 
     * @param int $id
     * @return LeaveResource|\Illuminate\Http\JsonResponse|mixed
     * 
     * @OA\Get (
     *     path="/api/leave/show/{id}",
     *     tags={"Leave"},
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
     *                     "id":1,
     *                     "created_at": null,
     *                      "updated_at": null,
     *                      "user_id": 2,
     *                      "company_id": 1,
     *                      "to_approve_id": 1,
     *                      "approve_id": null,
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "time_end": "2023-11-30 13:00:00",
     *                      "duration": "04:05:00",
     *                      "month": null,
     *                      "status_code": 2,
     *                      "type": 1,
     *                      "reason": null,
     *                      "reason_reject": null
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function show($id)
    {
        try {
            $result = $this->leaveRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new LeaveResource($result);
    }

    /**
     * Update the specified resource in storage.
     *      
     * @param \App\Http\Requests\LeaveRequest $request
     * @param int $id
     * @return LeaveResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Update Leave
     * @OA\Put (
     *     path="/api/leave/update/{id}",
     *     tags={"Leave"},
     *     summary="Get list of projects",
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
     *                          property="company_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="user_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="time_start",
     *                          type="string"
     *                      ),   
     *                      @OA\Property(
     *                          property="to_approve_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="duration",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="type",
     *                          type="number"
     *                      ),
     *                 ),
     *                 example={
     *                     "company_id": 1,
     *                     "user_id": 2,
     *                     "time_start": "2023-11-08 08:00:00",
     *                     "to_approve_id": 1,
     *                     "duration": "04:00:00",
     *                     "status_code": 1,
     *                     "type": 1
     *                }
     *             )
     *         )
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "company_id": 1,
     *                      "user_id": 2,
     *                      "to_approve_id": 1,
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "duration": "04:05:00",
     *                      "status_code": 1,
     *                      "type": 2,
     *                      "updated_at": "2023-08-22T03:13:38.000000Z",
     *                      "created_at": "2023-08-22T03:13:38.000000Z",
     *                      "id": 11
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function update(LeaveRequest $request, int $id)
    {
        try {
            $result = $this->leaveRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new LeaveResource($result);
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param int $id
     * @return \Illuminate\Contracts\Routing\ResponseFactory|\Illuminate\Http\JsonResponse|\Illuminate\Http\Response|mixed
     */
    /**
     * @OA\Delete(
     *   tags={"Leave"},
     *   path="/api/leave/{id}/destroy",
     *   summary="Leave destroy",
     *     @OA\Parameter(
     *         in="path",
     *         name="id",
     *         required=true,
     *         @OA\Schema(type="number")
     *     ),
     *   @OA\Response(
     *     response=200,
     *     description="OK",
     *   ),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function destroy(int $id)
    {
        try {
            $result = $this->leaveRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data' => ['message' => 'Delete Successfully']], 200);
    }
}