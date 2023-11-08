<?php

namespace App\Http\Resources\Company;

use App\Http\Resources\User\BasicUserResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CompanyResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'representative_name' => $this->representative_name,
            'address'=> $this->address,
            'category_code' => $this->category_code,
            'status_code' => $this->status_code,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'type_check_login' => $this->type_check_login,
            'type_work' => $this->type_work,
            'max_distance' => $this->max_distance ,
            'company_code' => $this->company_code,
            'number_staff' => $this->number_staff,
            'created_at' => $this->created_at,     
            'updated_at' => $this->updated_at,     
            'token'=>$this->token,
            'admin_id'=> $this->admin_id,
            "admin_info" => new BasicUserResource($this->admin)   
        ];
    }
}