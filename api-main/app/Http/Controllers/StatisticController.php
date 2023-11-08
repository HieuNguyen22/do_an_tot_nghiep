<?php

namespace App\Http\Controllers;

use App\Http\Services\StatisticService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class StatisticController extends Controller
{
    protected $statistic;
    public function __construct()
    {
        $this->statistic = new StatisticService();
    }

    /**
     * Summary of statistic user in Month
     * @return array
     */
    /**
     * Statistic leave, ot, attendane, late, early of account
     * @OA\Get(
     *   tags={"Admin"},
     *   path="/api/home/user/statistic",
     *    security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="user_id",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
     *                     "data": {
     *                          "user_id": 2,
     *                      }
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "data": {
     *                          "working_days": 2,
     *                          "working_hours": 1.8599999999999999,
     *                          "late_arrivals": 13,
     *                          "early_leaving": 11,
     *                          "leave_request": 1,
     *                          "hours_off": 2566.52,
     *                          "overtime_request": 1,
     *                          "overtime_hours": 3
     *                             }
     *                                  }
     *                }
     *         )
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function statisticUserMonth(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $request->input('user_id') ? $request->input('user_id') : Auth::guard('app-users')->user()->id;
        $statisticAttendance = $this->statistic->statisticAttendance($data);
        $statisticLeave = $this->statistic->statisticUserTotal($data, 'leaveRepository');
        $statisticOvertime = $this->statistic->statisticUserTotal($data, 'overtimeRepository');
        return response()->json(['data' => array_merge($statisticAttendance, $statisticLeave, $statisticOvertime)]);
    }


    /**
     * Summary of statistic company in Month
     * @return array
     */
    /**
     * Statistic leave, ot, attendane, late, early of account
     * @OA\Get(
     *   tags={"Admin"},
     *   path="/api/home/company/statistic",
     *   security={{"bearer_token": {}}},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *               @OA\Property(
     *                      type="object",
     *                      @OA\Property(
     *                          property="user_id",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="month",
     *                          type="number"
     *                      ),
     *                      @OA\Property(
     *                          property="time_checkin_start",
     *                          type="string"
     *                      ),
     *                      @OA\Property(
     *                          property="time_checkin_end",
     *                          type="string"
     *                      ),
     *                 ),
     *                 example={
     *                     "data": {
     *                          "month": 2,
     *                          "company_id":104,
     *                          "time_checkin_start":"2023-08-22",
     *                          "time_checkin_end":"2023-08-22"
     *                      }
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "data": {
     *                          "working_days": 2,
     *                          "working_hours": 1.8599999999999999,
     *                          "late_arrivals": 13,
     *                          "early_leaving": 11,
     *                          "leave_request": 1,
     *                          "hours_off": 2566.52,
     *                          "overtime_request": 1,
     *                          "overtime_hours": 3
     *                             }
     *                                  }
     *                }
     *         )
     *   ),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function statisticCompany(Request $request)
    {
        $data = $request->all();
        $data['company_id'] = $request->input('company_id') ? $request->input('company_id') : Auth::guard('app-users')->user()->company_id;
        $statisticAttendance = $this->statistic->statisticAttendance($data);
        $statisticLeave = $this->statistic->statisticCompanyTotal($data, 'leaveRepository');
        $statisticOvertime = $this->statistic->statisticCompanyTotal($data, 'overtimeRepository');
        return response()->json(['data' => array_merge($statisticAttendance, $statisticLeave, $statisticOvertime)]);
    }

    /**
     * statistic working time day by day
     * @OA\Get(
     *   tags={"Admin"},
     *   path="/api/home/user/timeWorkingDate",
     *   security={{"bearer_token": {}}},
     *    *     @OA\RequestBody(
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
     *                          property="month",
     *                          type="number"
     *                      )
     *                 ),
     *                 example={
     *                     "data": {
     *                          "user_id": 2,
     *                          "month": 2,
     *                      }
     *                 }
     *             )
     *         )
     *      ),
     *   @OA\Response(
     *      response=200,
     *       description="Success",
     *         @OA\JsonContent(
     *                 example={"data" : {
     *                     "data": {
     *                          "working_days": 2,
     *                          "working_hours": 1.8599999999999999,
     *                          "late_arrivals": 13,
     *                          "early_leaving": 11,
     *                          "leave_request": 1,
     *                          "hours_off": 2566.52,
     *                          "overtime_request": 1,
     *                          "overtime_hours": 3
     *                             }
     *                                  }
     *                }
     *         )
     *   ),     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function statisticTimeWorkingDate(Request $request)
    {
        $data = $request->all();
        $data['user_id'] = $request->input('user_id') ? $request->input('user_id') : Auth::guard('app-users')->user()->id;
        $data['company_id'] = Auth::guard('app-users')->user()->company_id;
        return response()->json(['data' => $this->statistic->statisticTimeWorkingDate($data)]);
    }
}