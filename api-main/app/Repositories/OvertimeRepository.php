<?php
namespace App\Repositories;

use App\Repositories\BaseRepository;
use App\Models\Overtime;

class OvertimeRepository extends BaseRepository
{
    /**
     * Specify Overtime class name
     *
     * @return string
     */
    public function model()
    {
        return Overtime::class;
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
        if (isset($params['company_id'])) {
            $conditionsFormated[] = ['company_id', '=',(int) $params['company_id']];
        }
        if (isset($params['user_id'])) {
            $conditionsFormated[] = ['user_id', '=',(int) $params['user_id']];
        }
        if (isset($params['created_at_start'])) {
            $conditionsFormated[] = ['created_at', '>=', $params['created_at_start']];
        }
        if (isset($params['created_at_end'])) {
            $conditionsFormated[] = ['created_at', '<=', $params['created_at_end']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=',(int) $params['status_code']];
        }
        if (isset($params['to_approve_id'])) {
            $conditionsFormated[] = ['to_approve_id', '=',(int) $params['to_approve_id']];
        }
        if (isset($params['approve_id'])) {
            $conditionsFormated[] = ['approve_id', '=',(int) $params['approve_id']];
        }
        if (isset($params['duration'])) {
            $conditionsFormated[] = ['duration', '=', $params['duration']];
        }
        if (isset($params['month'])) {
            $conditionsFormated[] = ['month', '=',(int) $params['month']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=',(int) $params['status_code']];
        }
        if (isset($params['type'])) {
            $conditionsFormated[] = ['type', '=',(int) $params['type']];
        }
        if (isset($params['reason'])) {
            $conditionsFormated[] = ['reason', 'like', '%' . $params['reason'] . '%'];
        }
        if (isset($params['reason_reject'])) {
            $conditionsFormated[] = ['reason_reject', 'like', '%' . $params['reason_reject'] . '%'];
        }
        if (isset($params['time_start_start'])) {
            $conditionsFormated[] = ['time_start', '>=', $params['time_start_start']];
        }
        if (isset($params['time_start_end'])) {
            $conditionsFormated[] = ['time_start', '<=', $params['time_start_end']];
        }
        if (isset($params['time_end_start'])) {
            $conditionsFormated[] = ['time_end', '>=', $params['time_end_start']];
        }
        if (isset($params['time_end_end'])) {
            $conditionsFormated[] = ['time_end', '<=', $params['time_end_end']];
        }
        $params['conditions'] = $conditionsFormated;
        return $this->searchByParams($params);
    }
}