<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Repositories;

use App\Models\Company;
use App\Repositories\BaseRepository;

class CompanyRepository extends BaseRepository
{
    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Company::class;
    }

    /**
     * Get data by multiple fields
     *
     * @param array $where
     * @param array $columns
     * @return mixed
     */
    public function search($params)
    {
        $conditionsFormated = [];
        if (isset($params['name'])) {
            $conditionsFormated[] = ['name', 'like', '%' . $params['name'] . '%'];
        }
        if (isset($params['representative_name'])) {
            $conditionsFormated[] = ['representative_name', 'like', '%' . $params['representative_name'] . '%'];
        }
        if (isset($params['id'])) {
            $conditionsFormated[] = ['id', '=', (int) $params['id']];
        }
        if (isset($params['company_code'])) {
            $conditionsFormated[] = ['company_code', 'like', '%' . $params['company_code'] . '%'];
        }
        if (isset($params['address'])) {
            $conditionsFormated[] = ['address', 'like', '%' . $params['address'] . '%'];
        }
        if (isset($params['category_code'])) {
            $conditionsFormated[] = ['category_code', '=', (int) $params['category_code']];
        }
        if (isset($params['status_code'])) {
            $conditionsFormated[] = ['status_code', '=', (int) $params['status_code']];
        }
        if (isset($params['type_check_login'])) {
            $conditionsFormated[] = ['type_check_login', '=', (int) $params['type_check_login']];
        }
        if (isset($params['type_work'])) {
            $conditionsFormated[] = ['type_work', '=', (int) $params['type_work']];
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

    public function getTotal() {
        return $this->count();
    }
}