<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\RoleRepository;
use App\Http\Requests\RoleRequest;
use App\Http\Resources\Role\RoleResource;

class RoleController extends Controller
{
    /**
     * @var Repository
     */
    protected $roleRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->roleRepository = new RoleRepository();
    }

    /**
     * Get data by multiple fields.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();

        $roles = $this->roleRepository->search($params);
        $jsonRoles = RoleResource::collection($roles);

        return $jsonRoles;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\RoleRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(RoleRequest $request)
    {
        $role = $this->roleRepository->create($request->all());
        $jsonRole = new RoleResource($role);
        
        return $jsonRole;
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - Role Id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $role = $this->roleRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonRole = new RoleResource($role);

        return $jsonRole;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\RoleRequest  $request
     * @param  int  $id - Role Id
     * @return \Illuminate\Http\Response
     */
    public function update(RoleRequest $request, $id)
    {
        try {
            $role = $this->roleRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonRole = new RoleResource($role);
        return $jsonRole;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id - Role Id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $result = $this->roleRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }

        return response($result);
    }
}
