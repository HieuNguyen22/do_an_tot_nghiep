<?php
namespace App\Http\Services;

use App\Exceptions\CheckinException;
use App\Http\Resources\Attendance\AttendanceResource;
use App\Models\Attendance;
use App\Models\Shift;
use App\Repositories\AttendanceRepository;
use App\Repositories\BaseRepository;
use App\Repositories\CompanyRepository;
use App\Repositories\ShiftRepository;
use App\Repositories\UsersRepository;
use App\Services\BaseService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class CheckinService extends BaseService
{
    /**
     * @var BaseRepository
     */
    protected $userRepository;
    protected $attendanceRepository;
    protected $companyRepository;
    protected $shiftRepository;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->userRepository = new UsersRepository();
        $this->attendanceRepository = new AttendanceRepository();
        $this->companyRepository = new CompanyRepository();
        $this->shiftRepository = new ShiftRepository();
    }

    /**
     * User checkin
     * 
     * @param mixed $shift_id
     * @throws \App\Exceptions\CheckinException
     * @return mixed
     */
    public function checkin($params)
    {
        $user = Auth::guard('app-users')->user();
        $type_check_login = $this->companyRepository->findOrFail($user->company_id)->type_check_login;
        $ip_checkin = ($type_check_login != config('contant.type_checkin.location')) ? request()->ip() : '';
        $last_checkin = $this->attendanceRepository->last($user->id);
        if ($last_checkin && $last_checkin->status_code == config('contant.attendance_status.checkedIn')) {
            throw new CheckinException('You need to perform a checkout before checking in again');
        }
        $params['user_id'] = $user->id;
        $params['month'] = Carbon::now()->month;
        $params['company_id'] = $user->company_id;
        $params['time_checkin'] = Carbon::now()->format('Y-m-d H:i:s');
        $params['status_code'] = config('contant.attendance_status.checkedIn');
        $params['ip_checkin'] = $ip_checkin;
        $params['type_checkin'] = $type_check_login;

        return $this->attendanceRepository->create( $params );

        // return $this->attendanceRepository->create([
        //     'user_id' => $user->id,
        //     'month'=> Carbon::now()->month,
        //     'company_id' => $user->company_id,
        //     'shift_id' => $params['shift_id'],
        //     'time_checkin' => Carbon::now()->format('Y-m-d H:i:s'),
        //     'status_code' => config('contant.attendance_status.checkedIn'),
        //     'ip_checkin'=> $ip_checkin,
        //     'type_checkin' => $type_check_login,
        //     'longitude_checkin' => $params['longitude_checkin'],
        //     'latitude_checkin' => $params['latitude_checkin'],
        // ]);
    }

    /**
     * User checkout the shift
     * 
     * @throws \App\Exceptions\CheckinException
     * @return mixed
     */
    public function checkout($params)
    {
        $last_checkin = $this->lastCheckin();
        $user = Auth::guard('app-users')->user();
        $type_check_login = $this->companyRepository->find($user->company_id)->type_check_login;
        $ip_checkout = ($type_check_login != config('contant.type_checkin.location')) ? request()->ip() : '';
        if (!$last_checkin || $last_checkin->status_code != config('contant.attendance_status.checkedIn')) {
            throw new CheckinException('You need to perform a checkin before checkout again');
        }

        return $this->attendanceRepository->update([
            'time_checkout' => Carbon::now()->format('Y-m-d H:i:s'),
            'status_code' => config('contant.attendance_status.checkedOut'),
            'ip_checkout' => $ip_checkout
        ], $last_checkin->id);
    }

    /**
     * Get the last user's checkin 
     * @return mixed
     */
    public function lastCheckin()
    {
        $user = Auth::guard('app-users')->user();
        return $this->attendanceRepository->last($user->id);
    }

    /**
     * Service Checkout Late
     * @param mixed $params
     * @throws \App\Exceptions\CheckinException
     * @return mixed
     */
    public function lateCheckout($params){
        $last_checkin = $this->lastCheckin();
        $current_time = Carbon::now();
        if (!$last_checkin || $last_checkin->status_code != config('contant.attendance_status.checkedIn')) {
            throw new CheckinException('You need to perform a checkin before checkout again');
        }
        if ($current_time->gt($last_checkin->time_checkout) && $current_time->diffInHours($last_checkin->time_checkout) > config('contant.check_out_limit')) {
            return $this->attendanceRepository->update([
                'time_checkout' => Carbon::now()->format('Y-m-d H:i:s'),
                'status_code' => config('contant.attendance_status.checkoutLate'),
                "reason" => $params['reason'],
                'duration' => $params['duration'],
                'to_approve_id'=> $params['to_approve_id']
            ], $last_checkin->id);
        }
        return $this->attendanceRepository->update([
            'time_checkout' => Carbon::now()->format('Y-m-d H:i:s'),
            'status_code' => config('contant.attendance_status.checkedOut')
        ], $last_checkin->id);
    }

    /**
     * Check IP to approve checkin
     * @return array
     */
    public function checkIP()
    {
        $today = Carbon::now();
        $params['time_checkin_start'] = $today->startOfDay()->toDateTimeLocalString();
        $params['time_checkin_end'] = $today->endOfDay()->toDateTimeLocalString();
        $params['limit'] = 10000;
        $params['type_checkin'] = config('contant.type_checkin.wifi');
        $params['status_code'] = config('contant.attendance_status.checkoutLate');
        $listCompany = $this->companyRepository->all();
        foreach ($listCompany as $key => $company) {
            $listIp = [];
            $params['company_id'] = $company->id;
            $listAttendances = $this->attendanceRepository->search($params);
            foreach ($listAttendances as $key => $value) {
                if (isset($listIp[$value->ip_checkin])) {
                    $listIp[$value->ip_checkin]++;
                } else {
                    $listIp[$value->ip_checkin] = 1;
                }
            }
            $threshold = floor(count($listAttendances) * 0.3);
            foreach ($listAttendances as $key => $value) {
                if ($listIp[$value->ip_checkin] > $threshold) {
                    $this->attendanceRepository->update([
                        'status_code' => config('contant.attendance_status.checkoutLate')
                    ], $value->id);
                }
            }

        }
    }
}