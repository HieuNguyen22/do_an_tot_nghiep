<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Leave extends Model
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
        'time_start',
        'time_end',
        'month',
        'duration',
        'status_code',
        'type',
        'to_approve_id',
        'reason',
        'approve_id',
        'reason_id',
        'reason_reject'
    ];

    public function user(){
        return $this->belongsTo(Users::class, 'user_id');
    }
}