<?php
namespace App\Http\Services;

use App\Repositories\AttendanceRepository;
use App\Repositories\BaseRepository;
use App\Repositories\CompanyRepository;
use App\Repositories\LeaveRepository;
use App\Repositories\OvertimeRepository;
use App\Repositories\ShiftRepository;
use App\Repositories\UsersRepository;
use App\Services\BaseService;
use Carbon\Carbon;


class StatisticService extends BaseService
{
    /**
     * @var BaseRepository
     */
    protected $userRepository;
    protected $attendanceRepository;
    protected $companyRepository;
    protected $leaveRepository;
    protected $shiftRepository;
    protected $overtimeRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->userRepository = new UsersRepository();
        $this->attendanceRepository = new AttendanceRepository();
        $this->companyRepository = new CompanyRepository();
        $this->leaveRepository = new LeaveRepository();
        $this->overtimeRepository = new OvertimeRepository();
        $this->shiftRepository = new ShiftRepository();
    }

    /**
     * Statistic attendance user or company
     * @param mixed $userId
     * @return array
     */
    public function statisticAttendance($params)
    {
        $params['limit'] = 10000;
        $workingDays = 0;
        $workingHours = 0;
        $lateArrivals = 0;
        $earlyLeaving = 0;
        $arrayTimes = [];
        if (isset($params['created_at_start']) && isset($params['created_at_end'])) {
            $allAttendances = $this->attendanceRepository->search($params);
        } else {
            $params['created_at_start'] = Carbon::now()->startOfMonth()->addDay();
            $params['created_at_end'] = Carbon::now()->endOfMonth();
            $allAttendances = $this->attendanceRepository->search($params);
        }
        foreach ($allAttendances as $attendance) {
            $timeCheckin = Carbon::parse($attendance->time_checkin);
            $timeCheckout = Carbon::parse($attendance->time_checkout);
            $param['id'] = $attendance->shift_id;
            if ($timeCheckin && $timeCheckout) {
                $workingHours += round(($timeCheckin->diffInSeconds($timeCheckout)) / 3600, 2);
                $arrayTimes[] = $timeCheckin->format('Y-m-d');

                if ($timeCheckin->format('H:i:s') > (Carbon::parse($this->shiftRepository->search($param)->first()->time_start))->format('H:i:s')) {
                    $lateArrivals++;
                }
                if ($timeCheckout->format('H:i:s') < (Carbon::parse($this->shiftRepository->search($param)->first()->time_end))->format('H:i:s')) {
                    $earlyLeaving++;
                }
            }
        }
        $arrayTimes = array_unique(array_values($arrayTimes));
        $workingDays = count($arrayTimes);
        return array("time_checkin" => count($allAttendances) ,'working_days' => $workingDays, 'working_hours' => $workingHours, 'late_arrivals' => $lateArrivals, 'early_leaving' => $earlyLeaving);
    }

    /**
     * Statistic leave and overtime request, hours of user
     * @param mixed $params
     * @param mixed $repoName
     * @return array
     */
    public function statisticUserTotal($params, $repoName)
    {
        $params['limit'] = 10000;
        $totalRequest = 0;
        $totalHours = 0;
        $property_name = ($repoName == 'overtimeRepository') ? 'overtime' : 'leave';
        if (isset($params['time_start_start']) && isset($params['time_start_end'])) {
            $allData = $this->$repoName->search($params);
        } else {
            $params['time_start_start'] = Carbon::now()->startOfMonth()->addDay();
            $params['time_start_end'] = Carbon::now()->endOfMonth();
            $allData = $this->$repoName->search($params);
        }
        foreach ($allData as $data) {
            $timeStart = Carbon::parse($data->time_start);
            $timeEnd = Carbon::parse($data->time_end);
            $totalRequest++;
            $totalHours += round(($timeEnd->diffInSeconds($timeStart)) / 3600, 2);
        }
        return array($property_name . '_request' => $totalRequest, $property_name . '_off' => $totalHours);
    }

    /**
     * Statistic Leave and overtime request, hour of company
     * @param mixed $userId
     * @return array
     */
    public function statisticCompanyTotal($params, $repoName)
    {
        $params['limit'] = 10000;
        $currentMonth = !isset($params['month']) ? Carbon::now()->month : $params['month'];
        $property_name = ($repoName == 'overtimeRepository') ? 'overtime' : 'leave';
        $allData = $this->$repoName->search($params);
        $totalRequests = 0;
        $totalOff = 0;

        foreach ($allData as $data) {
            $timeStart = Carbon::parse($data->time_start);
            $timeEnd = Carbon::parse($data->time_end);
            if ($timeStart->month == $currentMonth) {
                $totalRequests++;
                $totalOff += round(($timeStart->diffInSeconds($timeEnd)) / 3600, 2);
            }
        }
        return array($property_name . '_request' => $totalRequests, $property_name . '_off' => $totalOff);
    }


    /**
     * Summary of statisticTimeWorkingDate
     * @param mixed $params
     * @return void
     */
    public function statisticTimeWorkingDate($params)
    {
        $params['limit'] = 10000;
        $params['time_checkin_start'] = Carbon::parse($params['time_query'])->startOfMonth()->addDay();
        $params['time_checkin_end'] = Carbon::parse($params['time_query'])->endOfMonth();
        $allAttendances = $this->attendanceRepository->search($params);
        $result = $allAttendances->groupBy(function ($item) {
            return [Carbon::parse($item['time_checkin'])->toDateString()];
        })->map(function ($groupedItems) {
            $totalDuration = 0;
            foreach ($groupedItems as $item) {
                $checkin = Carbon::parse($item['time_checkin']);
                $checkout = Carbon::parse($item['time_checkout']);
                $duration = $checkout->diffInSeconds($checkin);
                $totalDuration += $duration;
            }

            $totalWorkHours = round($totalDuration / 3600, 2);
            return $totalWorkHours;
        });

        return $this->convertObject($result);
    }

    /**
     * Convert Object to Array
     * @param mixed $data
     * @return array<array>
     */
    public function convertObject($data)
    {
        if ($data) {
            $result = [];
            foreach ($data as $key => $value) {
                $result[] = [
                    'date' => $key,
                    'time' => $value
                ];
            }
            return $result;
        }
    }

}