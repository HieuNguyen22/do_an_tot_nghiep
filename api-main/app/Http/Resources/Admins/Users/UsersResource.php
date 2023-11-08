<?php

namespace App\Http\Resources\Admins\Users;

use App\Http\Resources\Company\CompanyResource;
use App\Http\Resources\Department\DepartmentResource;
use App\Http\Resources\Shift\ShiftResource;
use App\Models\Shift;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;

class UsersResource extends JsonResource
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
            'id' => $this->id,
            'email'=>$this->email,
            'company_id'=>$this->company_id,
            'employee_code'=>$this->employee_code,
            'first_name'=>$this->first_name,
            'last_name'=>$this->last_name,
            'address'=>$this->address,
            'status_code'=>$this->status_code,
            'type_login'=>$this->type_login,
            'type_work'=>$this->type_work,
            'type_shift'=>$this->type_shift,
            'department_id'=>$this->department_id,
            'shift_id'=>$this->shift_id,
            'role_code'=>$this->role_code,
            'token' => $this->token,
            "phone_number"=> $this->phone_number,
            "platform"=> $this->platform,
            "version"=> $this->version,
            "ip"=> $this->ip,
            "agent"=> $this->agent,
            "time_zone"=> $this->time_zone,
            "created_at"=> $this->created_at,
            "updated_at"=> $this->updated_at,
            'company_info'=> new CompanyResource($this->company),
            'department_info'=> new DepartmentResource($this->department),
            'shift_info' => new ShiftResource($this->shift_id != null ? Shift::find($this->shift_id)->first() : null),
        ];
    }
}