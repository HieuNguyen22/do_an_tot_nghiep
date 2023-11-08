<?php

namespace App\Http\Resources\Admins\Admin;

use App\Http\Resources\Role\RoleBasicResource;
use Illuminate\Http\Resources\Json\JsonResource;

class AdminResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        return [
            "id" => $this->id,
            "name" => $this->name,
            "email" => $this->email,
            'status' => $this->status,
            "token" => $this->token,
            "roles" => RoleBasicResource::collection($this->roles)
        ];
    }
}