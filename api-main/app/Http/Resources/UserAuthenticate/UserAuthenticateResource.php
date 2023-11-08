<?php

namespace App\Http\Resources\UserAuthenticate;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;

class UserAuthenticateResource extends JsonResource
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
            'token' => $this['token'],
            'refreshToken' => $this['refreshToken'],
            'user' => $this['user']
        ];
    }
}