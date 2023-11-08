<?php

namespace App\Http\Resources\User;

use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\Department\DepartmentResource;
use App\Http\Resources\Shift\ShiftResource;
use App\Models\Shift;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
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
            'email' => $this->email,
            'company_id' => $this->company_id,
            'employee_code' => $this->employee_code,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'address' => $this->address,
            'phone_number' => $this->phone_number,
            'status_code' => $this->status_code,
            'type_login' => $this->type_login,
            'type_work' => $this->type_work,
            'type_shift' => $this->type_shift,
            'department_id' => $this->department_id,
            'role_code' => $this->role_code,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'shift_id' => $this->shift_id,
            'company_info' => new CompanyResource($this->company),
            'department_info' => new DepartmentResource($this->department),
            'shift_info' => new ShiftResource($this->shift_id != null ? Shift::findOrFail($this->shift_id) : null),
        ];
    }
}