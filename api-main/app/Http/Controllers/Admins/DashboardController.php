<?php

namespace App\Http\Controllers\Admins;

use App\Http\Controllers\Controller;
use App\Repositories\AttendanceRepository;
use App\Repositories\CompanyRepository;
use App\Repositories\DepartmentRepository;
use App\Repositories\UsersRepository;
use App\Repositories\GameMiniRepository;
use App\Repositories\ElementRepository;
use App\Repositories\LeaveRepository;
use App\Repositories\SongRepository;
use App\Repositories\LessionRepository;
use App\Repositories\OvertimeRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class DashboardController extends Controller
{
    /**
     * @var Repository
     */
    protected $userRepository;
    protected $companyRepository;
    protected $overtimeRepository;
    protected $attendanceRepository;
    protected $leaveRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->userRepository = new UsersRepository();
        $this->companyRepository = new CompanyRepository();
        $this->overtimeRepository = new OvertimeRepository();
        $this->attendanceRepository = new AttendanceRepository();
        $this->leaveRepository = new LeaveRepository();
    }

    /**
     * Summary of getDashBoard
     * @return \Illuminate\Http\JsonResponse|mixed
     */
    /**
     * Get dashboard
     * @OA\Get(
     *   tags={"Admin"},
     *   path="/api/admins/dashboard",
     *   summary="Summary",
     *   @OA\Response(response=200, description="OK"),
     *   @OA\Response(response=401, description="Unauthorized"),
     *   @OA\Response(response=404, description="Not Found")
     * )
     */
    public function getDashBoard()
    {
        try {
            $totalUser = $this->userRepository->getTotalUser();
            $totalCompany = $this->companyRepository->getTotal();
            $totalOvertimeRequest = $this->overtimeRepository->getTotal();
            $totalLeaveRequest = $this->leaveRepository->getTotal();
            $totalAttendance = $this->attendanceRepository->getTotal();
            $result = [
                'totalUser' => $totalUser,
                'totalCompany' => $totalCompany,
                'totalOvertimeRequest' => $totalOvertimeRequest,
                'totalLeaveRequest' => $totalLeaveRequest,
                'totalAttendance' => $totalAttendance,
            ];
        } catch (\Throwable $th) {
            Log::error('exception: ' . $th->getMessage());
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        return response()->json(['data'=>$result]);
    }
}