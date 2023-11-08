<?php

namespace App\Http\Controllers;

use App\Http\Requests\AttendanceRequest;
use App\Http\Resources\Attendance\AttendanceResource;
use App\Repositories\AttendanceRepository;
use Carbon\Carbon;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    /**
     * Summary of repository
     * @var Repository
     */
    protected $attendanceRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->attendanceRepository = new AttendanceRepository();
    }

    /**
     * Get data by multiple fields.
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     * 
     * @OA\Get(
     *   tags={"Attendance"},
     *   path="/api/attendance",
     *   summary="Attendance index",
     *   @OA\Response(
     *     response=200,
     *     description="OK",
     *     @OA\JsonContent(
     *       type="object",
     *       @OA\Property(
     *         property="data",
     *         type="array",
     *         @OA\Items(ref="App\Http\Resources\Attendance\AttendanceResource")
     *       ),
     *       @OA\Property(property="links"),
     *       @OA\Property(property="meta")
     *     )
     *   )
     * )
     */
    public function index(Request $request)
    {
        $params = $request->all();
        $attendances = $this->attendanceRepository->search($params);
        return AttendanceResource::collection($attendances);
    }

    /**
     * Store a newly created resource in storage.
     * 
     * @param \App\Http\Requests\AttendanceRequest $request
     * @return AttendanceResource
     *
     * @OA\Post(
     *   tags={"Attendance"},
     *   path="/api/attendance/store",
     *   summary="Attendance store",
     *  @OA\RequestBody(
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
     *                          property="company_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="shift_id",
     *                          type="number"
     *                      ),   
     *                      @OA\Property(
     *                          property="time_checkin",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_checkout",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="duration",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="month",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_checkin",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_work",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="reason",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                      "user_id": 1,
     *                      "company_id": 1,
     *                      "shift_id": 1,
     *                      "time_checkin": "2023-08-23 04:45:18",
     *                      "time_checkout": "2023-08-23 04:45:18",
     *                      "duration": "04:45:18",
     *                      "month": 1,
     *                      "type_checkin": 1,
     *                      "type_work": 1,
     *                      "status_code": 1,
     *                      "reason": "Hehehe"
     *                }
     *             )
     *         )
     *      ),
     *   @OA\Response(response=201, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function store(AttendanceRequest $request)
    {
        $request->merge(['month'=>Carbon::parse($request->time_checkin)->month]);
        $attendance = $this->attendanceRepository->create($request->all());
        return new AttendanceResource($attendance);
    }

    /**
     * Get Object By Id.
     *      
     * @param int $id
     * @return AttendanceResource|\Illuminate\Http\JsonResponse|mixed
     * 
     * @OA\Get(
     *   tags={"Attendance"},
     *   path="/api/attendance/show/{id}",
     *   summary="Attendance show",
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
    public function show(int $id)
    {
        try {
            $attendance = $this->attendanceRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }

        return new AttendanceResource($attendance);
    }

    /**
     * Update the specified resource in storage.
     * 
     * @param \App\Http\Requests\AttendanceRequest $request
     * @param int $id - Shift Id
     * @return AttendanceResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * @OA\Put(
     *   tags={"Attendance"},
     *   path="/api/attendance/{id}/update",
     *   summary="Attendance update",
     *   @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
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
     *                          property="company_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="shift_id",
     *                          type="number"
     *                      ),   
     *                      @OA\Property(
     *                          property="time_checkin",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_checkout",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="duration",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="month",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_checkin",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="type_work",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="reason",
     *                          type="string"
     *                      )
     *                 ),
     *                 example={
     *                      "user_id": 1,
     *                      "company_id": 1,
     *                      "shift_id": 1,
     *                      "time_checkin": "2023-08-23 04:45:18",
     *                      "time_checkout": "2023-08-23 04:45:18",
     *                      "duration": "04:45:18",
     *                      "month": 1,
     *                      "type_checkin": 1,
     *                      "type_work": 1,
     *                      "status_code": 1,
     *                      "reason": "Hehehe"
     *                }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *     response=200,
     *     description="OK",
     *   ),
     *   @OA\Response(response=404, description="Not Found"),
     *   @OA\Response(response=422, description="Unprocessable Entity")
     * )
     */
    public function update(AttendanceRequest $request, int $id)
    {
        try {
            $attendance = $this->attendanceRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new AttendanceResource($attendance);
    }


    /**
     * Update Status.
     * 
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return AttendanceResource|\Illuminate\Http\JsonResponse|mixed
     */
    /**
     * @OA\PUT(
     *   tags={"Attendance"},
     *   path="/api/attendance/{id}/updateStatus",
     *   summary="Summary",
     *   @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
     *  @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="status_code",
     *                          type="number"
     *                      ),
     *                 ),
     *                 example={
     *                      "status_code": 1,
     *                }
     *             )
     *         )
     *      ),
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function updateStatus(Request $request, int $id)
    {
        try {
            $attendance = $this->attendanceRepository->update($request->only('status_code'), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return new AttendanceResource($attendance);
    }

    /**
     * Remove the specified resource from storage.
     * 
     * @param int $id
     * @return \Illuminate\Contracts\Routing\ResponseFactory|\Illuminate\Http\JsonResponse|\Illuminate\Http\Response|mixed
     * 
     * @OA\Delete(
     *   tags={"Attendance"},
     *   path="/api/attendance/{id}/destroy",
     *   summary="Attendance destroy",
     *   @OA\Parameter(
     *      name="id",
     *      in="path",
     *      required=true,
     *      @OA\Schema(type="integer")
     *   ),
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function destroy(int $id)
    {
        try {
            $result = $this->attendanceRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data' => ['message' => 'Delete Successfully']], 200);
    }
}