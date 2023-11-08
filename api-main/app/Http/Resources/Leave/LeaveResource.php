<?php

namespace App\Http\Resources\Leave;

use App\Http\Resources\User\BasicUserResource;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LeaveResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'=>$this->id,
            'user_id'=>$this->user_id,
            'company_id'=>$this->company_id,
            'to_approve_id'=>$this->to_approve_id,
            'approve_id' =>$this->approve_id,
            'time_start'=>$this->time_start,
            'time_end'=>$this->time_end,
            'duration'=>$this->duration,
            "month"=> $this->month,
            "status_code"=> $this->status_code,
            "type"=> $this->type,
            "reason"=> $this->reason,
            "reason_reject"=> $this->reason_reject,
            'user_info'=>new BasicUserResource($this->user)
        ];
    }
}
