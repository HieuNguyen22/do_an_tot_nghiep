<?php

namespace App\Http\Controllers;

use App\Repositories\PermissionRepository;
use App\Http\Resources\Permission\PermissionGroup;

class PermissionController extends Controller
{
    /**
     * @var Repository
     */
    protected $permissionRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->permissionRepository = new PermissionRepository();
    }


    /**
     * Get All.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $permissions = $this->permissionRepository->all();
        $jsonPermissions = PermissionGroup::collection($permissions->groupBy('group'));
        $result = [];
        foreach ($jsonPermissions as $key =>  $jsonPermission) {
            $result[] = $jsonPermission;
        }
        return [
            "data"=>$result
        ];
    }
}
