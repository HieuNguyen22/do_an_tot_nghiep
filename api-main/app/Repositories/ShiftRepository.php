<?php

namespace App\Repositories;

use App\Models\Shift;

class ShiftRepository extends BaseRepository
{
    /**
     * Specify Model class name
     * 
     * @return string
     */
    public function model()
    {
        return Shift::class;
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
            $conditionsFormated[] = ['company_id', '=', $params['company_id']];
        }
        if (isset($params['name'])) {
            $conditionsFormated[] = ['name', 'like', '%' . $params['name'] . '%'];
        }
        if (isset($params['type'])) {
            $conditionsFormated[] = ['type', '=', $params['type']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=', $params['status_code']];
        }
        if (isset($params['time_start_start'])) {
            $conditionsFormated[] = ['time_start', '>=', $params['time_start_start']];
        }
        if (isset($params['time_end_end'])) {
            $conditionsFormated[] = ['time_end', '<=', $params['time_end_end']];
        }
        if (isset($params['duration'])) {
            $conditionsFormated[] = ['duration', '=', $params['duration']];
        }
        if (isset($params['id'])) {
            $conditionsFormated[] = ['id', '=', $params['id']];
        }
        if (isset($params['created_at_start'])) {
            $conditionsFormated[] = ['created_at', '>=', $params['created_at_start']];
        }
        if (isset($params['created_at_end'])) {
            $conditionsFormated[] = ['created_at', '<=', $params['created_at_end']];
        }
        $params['conditions'] = $conditionsFormated;
        return $this->searchByParams($params);
    }
}