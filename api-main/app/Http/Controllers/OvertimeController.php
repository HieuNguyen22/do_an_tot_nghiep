<?php

namespace App\Http\Controllers;

use App\Http\Requests\OvertimeRequest;
use App\Http\Resources\Overtime\OvertimeResource;
use App\Repositories\BaseRepository;
use App\Repositories\OvertimeRepository;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OvertimeController extends Controller
{
    /**
     * @var BaseRepository
     */
    protected BaseRepository $overtimeRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->overtimeRepository = new OvertimeRepository();
    }

    /**
     * Get list data by multiple fields
     * 
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse|\Illuminate\Http\Resources\Json\AnonymousResourceCollection|mixed
     * 
     * @OA\Get(
     *   tags={"Overtime"},
     *   path="/api/overtime",
     *   summary="Overtime index",
     *   @OA\Response(
     *     response=200,
     *     description="OK",
     *     @OA\JsonContent(
     *       type="object",
     *     )
     *   )
     * )
     */
    public function index(Request $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();
        try {
            $result = $this->overtimeRepository->search($params);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return OvertimeResource::collection($result);
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param \App\Http\Requests\OvertimeRequest $request
     * @param int $id
     * @return OvertimeResource|\Illuminate\Http\JsonResponse|mixed
     * 
     * @OA\Put(
     *   tags={"Overtime"},
     *   path="/api/overtime/{id}/update",
     *   summary="Overtime update",
     *   security={{"bearer_token": {}}},
     *   @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
     *   @OA\RequestBody(
     *     @OA\MediaType(
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
     *                      )
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
     *   ),
     *   @OA\Response(
     *     response=201,
     *     description="OK",
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found"),
     *   @OA\Response(response=422, description="Unprocessable Entity")
     * )
     */
    public function update(OvertimeRequest $request, int $id)
    {
        try {
            $result = $this->overtimeRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new OvertimeResource($result);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param \App\Http\Requests\OvertimeRequest $request
     * @return OvertimeResource|\Illuminate\Http\JsonResponse|mixed
     * 
     * @OA\Post(
     *   tags={"Overtime"},
     *   path="/api/overtime/store",
     *   summary="Overtime store",
     *   security={{"bearer_token": {}}},
     *   
     *   @OA\RequestBody(
     *     @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
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
     *                      )
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
     *   ),
     *   @OA\Response(
     *     response=201,
     *     description="OK",
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function store(OvertimeRequest $request)
    {
        try {
            $user = Auth::guard('app-users')->user();
            $request->merge(['user_id' => $user->id]);
            $request->merge(['company_id' => $user->company_id]);
            $request->merge(['month' => Carbon::parse($request->time_start)->month]);
            $result = $this->overtimeRepository->create($request->all());
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new OvertimeResource($result);
    }

    /**
     * Get Object By Id.
     * 
     * @param int $id
     * @return OvertimeResource|\Illuminate\Http\JsonResponse|mixed
     * 
     * @OA\Get(
     *   path="/api/overtime/{id}/show",
     *   summary="Overtime show",
     *   tags={"Overtime"},
     *   @OA\Parameter(
     *      name="id",
     *           in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
     *   @OA\Response(
     *     response=200,
     *     description="OK",
     *     @OA\JsonContent(ref="App\Http\Resources\Overtime\OvertimeResource")
     *   ),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */

    public function show(int $id)
    {
        try {
            $result = $this->overtimeRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new OvertimeResource($result);
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param int $id
     * @return \Illuminate\Contracts\Routing\ResponseFactory|\Illuminate\Http\JsonResponse|\Illuminate\Http\Response|mixed
     * 
     * @OA\Delete(
     *   tags={"Overtime"},
     *   path="/api/overtime/{id}/destroy",
     *   summary="Overtime destroy",
     *   @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
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
            $result = $this->overtimeRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data' => ['message' => 'Delete Successfully']], 200);
    }
}