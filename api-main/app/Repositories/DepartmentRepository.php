<?php
/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Repositories;

use App\Repositories\BaseRepository;
use App\Models\Department;

class DepartmentRepository extends BaseRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Department::class;
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

        if (isset($params['name'])) {
            $conditionsFormated[] = ['name', 'like', '%'.$params['name'].'%'];
        }

        if (isset($params['company_id'])) {
            $conditionsFormated[] = ['company_id' , '=', (int) $params['company_id']];
        }
        if (isset($params['manager_id'])) {
            $conditionsFormated[] = ['manager_id' , '=', (int) $params['manager_id']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code' , '=', (int) $params['status_code']];
        }
        if (isset($params['id'])) {
            $conditionsFormated[] = ['id' , '=', (int) $params['id']];
        }
        if (isset($params['created_at_start'])) {
            $conditionsFormated[] = ['created_at', '>=', $params['created_at_start']];
        }
        if (isset($params['created_at_end'])) {
            $conditionsFormated[] = ['created_at', '<=', $params['created_at_end']];
        }

        $params['conditions'] = $conditionsFormated;
        $result = $this->searchByParams($params);

        return $result;
    }
    
}