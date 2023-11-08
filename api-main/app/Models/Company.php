<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Company extends Model
{
    use HasFactory;
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name',
        'representative_name',
        'address',
        'category_code',
        'status_code',
        'latitude',
        'longitude',
        'type_check_login',
        'type_work',
        'max_distance',
        'company_code',
        'admin_id'
    ];

    public function admin(){
        return $this->belongsTo(Users::class, 'admin_id');
    }
}