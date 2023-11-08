<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;

class Users extends Authenticatable implements JWTSubject
{
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [];
    
    protected $fillable = [
        'email',
        'company_id',
        'employee_code',
        'first_name',
        'last_name',
        'address',
        'password',
        'status_code',
        'type_login',
        'type_work',
        'type_shift',
        'department_id',
        'role_code',
        'shift_id',
        'user_name',
        
        'gold',
        'diamond',
        'avatar',
        'gender_type',
        'full_name',
        'country',
        'city',
        'phone_number',
        'zip_code',
        'age',
        'account_type',
        'ref_code',
        'parent_code',
        'parent_id',
        'level',
        'platform',
        'version',
        'experience',
        'status',
        'country_code',
        'game_type',
        'ip',
        'agent',
        'time_zone',
        'refresh_token',
    ];

    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function company(){
        return $this->belongsTo(Company::class, 'company_id');
    }
    
    public function department(){
        return $this->belongsTo(Department::class, 'department_id');
    }
}
