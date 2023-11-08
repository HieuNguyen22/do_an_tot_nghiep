<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Repositories;

use App\Repositories\BaseRepository;
use App\Models\Admin;
use Illuminate\Support\Facades\Hash;

class AdminRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [];

    /**
     *
     */
    public function boot()
    {
        //
    }

    /**
     * Specify Model class name
     *
     * @return string
     */
    public function model()
    {
        return Admin::class;
    }


    /**
     * Get data by multiple fields
     *
     * @param array $params
     * @return mixed
     */
    public function search($params)
    {
        $conditions = $this->getSearchConditions($params);
        $conditionsFormated = [];

        if (isset($conditions['name'])) {
            $conditionsFormated[] = ['name', 'like', '%' . $params['name'] . '%'];
        }

        if (isset($conditions['email'])) {
            $conditionsFormated[] = ['email', 'like', '%' . $params['email'] . '%'];
        }

        if (isset($conditions['status'])) {
            $conditionsFormated[] = ['status', '=', (int) $conditions['status']];
        }

        $params['conditions'] = $conditionsFormated;
        $result = $this->searchByParams($params);

        return $result;
    }

    /**
     * Save a new user in repository
     *
     * @param array $attributes
     * @return mixed
     */
    public function create(array $attributes)
    {
        $attributes['password'] = Hash::make($attributes['password']);

        return parent::create($attributes);
    }

    /**
     * Update Password 
     *
     * @param array $attributes
     * @param int $id - User Id
     * @return mixed
     */
    public function update(array $attributes, $id)
    {
        if (isset($attributes['password'])) {
            $attributes['password'] = Hash::make($attributes['password']);
        }

        return parent::update($attributes, $id);
    }
}