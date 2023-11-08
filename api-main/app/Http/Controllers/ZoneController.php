<?php

/**
 * Copyright 2021 DevFast Limited. All rights reserved.
 * Email: tech@devfast.us
 * Website: http://devfast.us/
 */

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\ZoneRepository;
use App\Http\Requests\ZoneRequest;
use App\Http\Resources\Zone\ZoneResource;
use App\Http\Resources\Zone\ZoneBasicResource;

class ZoneController extends Controller
{
    /**
     * @var Repository
     */
    protected $zoneRepository;

    /**
     * Construct
     */
    public function __construct()
    {
        $this->zoneRepository = new ZoneRepository();
    }

    /**
     * Get data by multiple fields.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request  $request)
    {
        $params = $request->all();
        $params['conditions'] = $request->all();

        $zones = $this->zoneRepository->search($params);
        $jsonZones = ZoneResource::collection($zones);

        return $jsonZones;
    }

    /**
     * get all data
     *
     * @return \Illuminate\Http\Response
     */
    public function getAllZoneBasic()
    {
        $zones = $this->zoneRepository->all(['id','name']);
        $jsonZones = ZoneBasicResource::collection($zones);

        return $jsonZones;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\Zone\GroupRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(ZoneRequest $request)
    {
        $zone = $this->zoneRepository->create($request->all());
        $jsonZone = new ZoneResource($zone);

        return $jsonZone;
    }

    /**
     * Get Object By Id.
     *
     * @param  int  $id - zone id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $zone = $this->zoneRepository->findOrFail($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonZone = new ZoneResource($zone);

        return $jsonZone;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  App\Http\Requests\Zone\ZoneRequest  $request
     * @param  int  $id - zone id
     * @return \Illuminate\Http\Response
     */
    public function update(ZoneRequest $request, $id)
    {
        try {
            $zone = $this->zoneRepository->update($request->all(), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonZone = new ZoneResource($zone);

        return $jsonZone;
    }

    /**
     * Update Status.
     *
     * @param  Illuminate\Http\Request  $request
     * @param  int  $id - zone id
     * @return \Illuminate\Http\Response
     */
    public function updateStatus(Request $request, $id)
    {
        try {
            $zone = $this->zoneRepository->update($request->only('status'), $id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }
        $jsonZone = new ZoneResource($zone);

        return $jsonZone;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id - zone id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $result = $this->zoneRepository->delete($id);
        } catch (\Throwable $th) {
            return response()->json([
                'data' => ['errors' => ['exception' => $th->getMessage()]]
            ], 400);
        }

        return response($result);
    }
}
