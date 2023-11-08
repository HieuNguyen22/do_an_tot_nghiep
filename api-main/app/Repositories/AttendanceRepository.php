<?php
namespace App\Repositories;

use App\Models\Attendance;
use Carbon\Carbon;

class AttendanceRepository extends BaseRepository
{
    /**
     * Specify Model class name
     * 
     * @return string
     */
    public function model()
    {
        return Attendance::class;
    }

    /**
     * Get data by multiple fields
     *
     * @param array $params 
     * @return mixed
     */
    public function search($params)
    {
        $conditionsFormated = [];
        if (isset($params['month'])) {
            $conditionsFormated[] = ['month', '=',(int) $params['month']];
        }
        if (isset($params['shift_id'])) {
            $conditionsFormated[] = ['shift_id', '=',(int) $params['shift_id']];
        }
        if (isset($params['user_id'])) {
            $conditionsFormated[] = ['user_id', '=', (int) $params['user_id']];
        }
        if (isset($params['company_id'])) {
            $conditionsFormated[] = ['company_id', '=',(int) $params['company_id']];
        }
        if (isset($params['time_checkin_start'])) {
            $conditionsFormated[] = ['time_checkin', '>=', $params['time_checkin_start']];
        }
        if (isset($params['time_checkin_end'])) {
            $conditionsFormated[] = ['time_checkin', '<=', $params['time_checkin_end']];
        }
        if (isset($params['time_checkout_start'])) {
            $conditionsFormated[] = ['time_checkout', '>=', $params['time_checkout_start']];
        }
        if (isset($params['time_checkout_end'])) {
            $conditionsFormated[] = ['time_checkout', '<=', $params['time_checkout_end']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=',(int) $params['status_code']];
        }
        if (isset($params['type'])) {
            $conditionsFormated[] = ['type', '=',(int) $params['type']];
        }
        if (!isset($params['sort_by'])) {
            $params['sort_by'] = 'created_at';
        }
        if (!isset($params['sort_type']) || ($params['sort_type'] != 'asc' && $params['sort_type'] != 'desc')) {
            $params['sort_type'] = 'desc';
        }
        $params['conditions'] = $conditionsFormated;
        return $this->searchByParams($params);
    }


    /**
     * get 
     * 
     * @param mixed $user_id
     * @return mixed
     */
    public function last($user_id)
    {
        // $this->orderBy('created_at', 'desc');
        $params = [
            'sort_by' => 'created_at',
            'sort_type' => 'desc',
            'user_id' => $user_id
        ];
        return $this->search($params)->first();
    }
}