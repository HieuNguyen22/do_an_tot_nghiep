<?php

namespace App\Http\Controllers;

use App\Http\Requests\ShiftRequest;
use App\Http\Resources\Shift\ShiftResource;
use App\Repositories\ShiftRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ShiftController extends Controller
{
    /**
     * Summary of shiftRepository
     * 
     * @var Repository
     */
    protected $shiftRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->shiftRepository = new ShiftRepository();
    }

    /**
     * Get data by multiple fields.
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
     /**
     * Get all Shift
     * 
     * @OA\Get (
     *     path="/api/company/shift",
     *     tags={"Shift"},
     *      security={{"bearer_token": {}}},
     *      @OA\Response(
     *          response=200,
     *          description="success",
     *          @OA\JsonContent(
     *                 example={"data" : {
     *                      "id": 1,
     *                      "created_at": null,
     *                      "updated_at": null,
     *                      "company_id": 1,
     *                      "name": "Ca sang",
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "time_end": "2023-11-30 13:00:00",
     *                      "duration": "04:05:00",
     *                      "status_code": 2,
     *                      "type": 1,
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
        $shifts = $this->shiftRepository->search($params);
        return ShiftResource::collection($shifts);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param \App\Http\Requests\ShiftRequest $request
     * @return ShiftResource
     */
    /**
     * Create shift
     * @OA\Post (
     *     path="/api/shift/store",
     *     tags={"Shift"},
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
     *                          property="name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_start",
     *                          type="string"
     *                      ),   
     *                      @OA\Property(
     *                          property="duration",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_end",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
     *                     "company_id": 1,
     *                     "name": "Ca sang",
     *                     "time_start": "08:00:00",
     *                     "time_end": "12:00:00",
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
     *                      "id": 8,
     *                     "company_id": 1,
     *                     "name": "Ca sang",
     *                     "time_start": "08:00:00",
     *                     "time_end": "12:00:00",
     *                     "duration": "04:00:00",
     *                     "status_code": 1,
     *                     "type": 1,
     *                     "created_at":"2023-02-01T09:25:53.000000Z",
     *                     "updated_at":"2023-02-01T09:25:53.000000Z"
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
    public function store(ShiftRequest $request)
    {
        try {
            $result = $this->shiftRepository->create($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new ShiftResource($result);
    }

    /**
     * Get Object By Id.
     *      
     * @param int $id
     * @return ShiftResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Get Detail Shift
     * @OA\Get (
     *     path="/api/company/shift/show/{id}",
     *     tags={"Shift"},
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
     *                      "company_id": 1,
     *                      "name": "Ca sang",
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "time_end": "2023-11-30 13:00:00",
     *                      "duration": "04:05:00",
     *                      "status_code": 2,
     *                      "type": 1,
     *                      }
     *                }
     *         )
     *     )
     * )
     */
    public function show($id)
    {
        try {
            $shift = $this->shiftRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new ShiftResource($shift);
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param \App\Http\Requests\ShiftRequest $request
     * @param int $id - Shift Id
     * @return ShiftResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Update Shift
     * @OA\Put (
     *     path="/api/company/shift/update/{id}",
     *     tags={"Shift"},
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
     *                          property="name",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_start",
     *                          type="string"
     *                      ),   
     *                      @OA\Property(
     *                          property="time_end",
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
     *                      )
     *                 ),
     *                 example={
     *                     "company_id": 1,
     *                     "name": "string",
     *                     "user_id": 2,
     *                     "time_start": "2023-11-08 08:00:00",
     *                     "time_end": "2023-11-08 08:00:00",
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
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "id":1,
     *                     "created_at": null,
     *                      "updated_at": null,
     *                      "company_id": 1,
     *                      "name": "Ca sang",
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "time_end": "2023-11-30 13:00:00",
     *                      "duration": "04:05:00",
     *                      "status_code": 2,
     *                      "type": 1,
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function update(ShiftRequest $request, int $id)
    {
        try {
            $result = $this->shiftRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new ShiftResource($result);
    }

    /**
     * Update Status.
     * 
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return ShiftResource|\Illuminate\Http\JsonResponse|mixed
     */
     /**
     * Update Shift Status
     * @OA\Put (
     *     path="/api/company/shift/updateStatus/{id}",
     *     tags={"Shift"},
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
     *                          property="status_code",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
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
     *                     "id":1,
     *                     "created_at": null,
     *                      "updated_at": null,
     *                      "company_id": 1,
     *                      "name": "Ca sang",
     *                      "time_start": "2023-08-15 14:28:44",
     *                      "time_end": "2023-11-30 13:00:00",
     *                      "duration": "04:05:00",
     *                      "status_code": 2,
     *                      "type": 1,
     *                                  }
     *                }
     *         )
     *      )
     * )
     */
    public function updateStatus(Request $request, int $id)
    {
        try {
            $result = $this->shiftRepository->update($request->only('status_code'), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new ShiftResource($result);
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param int $id
     * @return \Illuminate\Contracts\Routing\ResponseFactory|\Illuminate\Http\JsonResponse|\Illuminate\Http\Response|mixed
     */
     /**
     * Delete Shift
     * @OA\Delete (
     *     path="/api/company/shift/destroy/{id}",
     *     tags={"Shift"},
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
    public function destroy(int $id)
    {
        try {
            $result = $this->shiftRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data'=>['message'=>'Delete Successfully']],200);
    }
}
