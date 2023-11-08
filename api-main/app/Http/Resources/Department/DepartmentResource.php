<?php

namespace App\Http\Resources\Department;

use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\User\BasicUserResource;
use App\Http\Resources\User\UserResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DepartmentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'company_id' => $this->company_id,
            'manager_id' => $this->manager_id,
            'status_code' => $this->status_code,
            'created_at'=>$this->created_at,
            'updated_at'=>$this->updated_at,
            'company_info' => new CompanyResource($this->company),
            'manager_info' => new BasicUserResource($this->user)
        ];
    }
}
