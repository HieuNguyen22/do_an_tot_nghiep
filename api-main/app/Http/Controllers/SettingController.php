<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\SettingRepository;
use App\Http\Requests\SettingRequest;
use App\Http\Resources\Setting\SettingResource;

class SettingController extends Controller
{
    /**
     * @var Repository
     */
    protected $settingRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->settingRepository = new SettingRepository();
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request  $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();

        $setting = $this->settingRepository->search($params);
        $jsonSetting = SettingResource::collection($setting);

        return  $jsonSetting;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\Thing\ThingRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(SettingRequest $request)
    {
        $setting = $this->settingRepository->create($request->all());
        $jsonSetting = new SettingResource($setting);
        return $jsonSetting;
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - setting id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $setting = $this->settingRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonSetting = new SettingResource($setting);
        return $jsonSetting;
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  App\Http\Requests\Thing\SettingRequest  $request
     * @param  int  $id - setting id
     * @return \Illuminate\Http\Response
     */
    public function update(SettingRequest $request, $id)
    {
        try {
            $setting = $this->settingRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonSetting = new SettingResource($setting);
        return $jsonSetting;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id - setting id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $result = $this->settingRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }

        return response($result);
    }
}
