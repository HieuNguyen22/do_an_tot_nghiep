<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id',
        'company_id',
        'time_checkin',
        'time_checkout',
        'month',
        'duration',
        'type_checkin',
        'type_work',
        'shift_id',
        'status_code',
        'reason',
        'ip_checkin',
        'ip_checkout',
        'latitude_checkin',
        'longitude_checkin',
        'latitude_checkout',
        'longitude_checkout',
    ];

    public function shift(){
        return $this->belongsTo(Shift::class,"shift_id");
    }
    public function user(){
        return $this->belongsTo(Users::class,"user_id");
    }
}
