<?php

namespace App\Http\Resources\Attendance;

use App\Http\Resources\Shift\ShiftResource;
use App\Http\Resources\User\BasicUserResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AttendanceResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "id"=> $this->id,
            "created_at"=> $this->created_at,
            "updated_at"=> $this->updated_at,
            "user_id"=> $this->user_id,
            "company_id"=> $this->company_id,
            "shift_id"=> $this->shift_id,
            "time_checkin"=> $this->time_checkin,
            "time_checkout"=> $this->time_checkout,
            "duration"=> $this->duration,
            "month"=> $this->month,
            "type_checkin"=> $this->type_checkin,
            "type_work"=> $this->type_work,
            "status_code"=> $this->status_code,
            "reason"=> $this->reason,
            "ip_checkin"=> $this->ip_checkin,
            "ip_checkout"=> $this->ip_checkout,
            "latitude_checkin"=> $this->latitude_checkin,
            "longitude_checkin"=> $this->longitude_checkin,
            "latitude_checkout"=> $this->latitude_checkout,
            "longitude_checkout"=> $this->longitude_checkout,
            "shift_info"=> new ShiftResource($this->shift),
            'user_info'=> new BasicUserResource($this->user)
        ];
    }
}
