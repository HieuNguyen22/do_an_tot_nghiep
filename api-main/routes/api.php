<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admins\AdminController;
use App\Http\Controllers\Admins\UsersController;
use App\Http\Controllers\Admins\DashboardController;
use App\Http\Controllers\RoleController;
use App\Http\Controllers\PermissionController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CompanyController;
use App\Http\Controllers\ShiftController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\LeaveController;
use App\Http\Controllers\OvertimeController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\StatisticController;
use App\Mail\HelloMail;
use Illuminate\Support\Facades\Mail;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('user/forgotPassword', [UserController::class, 'forgotPassword']);
Route::post('auth/login', [UserController::class, 'loginUser']);
Route::post('auth/logout', [UserController::class, 'logout']);
Route::post('company/register', [CompanyController::class, 'register']);
Route::post('auth/register', [UserController::class, 'registerUser']);
Route::get('company/getByCode/{company_code}', [CompanyController::class, 'getByCode']);
Route::get('checkIP', [UserController::class, 'checkIP']);
Route::put('user/changePasswordByUserId', [UserController::class, 'changePasswordByUserId']);

Route::group(['middleware' => ['jwt.verify','user.status']], function () {
    Route::post('user/checkin', [UserController::class, 'checkin']);
    Route::put('user/checkout', [UserController::class, 'checkout']);
    Route::get('user/show', [UserController::class, 'show']);
    Route::put('user/update', [UserController::class, 'update']);
    Route::get('user/lastCheckin', [UserController::class, 'lastCheckin']);
    Route::get('user/overtime', [UserController::class, 'overtime']);
    Route::get('user/leave', [UserController::class, 'leave']);
    Route::get('user/company', [UserController::class, 'company']);
    Route::get('user/department', [UserController::class, 'department']);
    Route::put('user/lateCheckout', [UserController::class, 'lateCheckout']);
    Route::put('user/joinIntoCompany', [UserController::class, 'joinIntoCompany']);
    Route::put('user/addIntoDepartment', [UserController::class, 'addIntoDepartment']);
    Route::put('user/changePassword', [UserController::class, 'changePassword']);

    Route::get('leave', [LeaveController::class, 'index']);
    Route::post('leave/store', [LeaveController::class, 'store']);
    Route::get('leave/show/{id}', [LeaveController::class, 'show']);
    Route::put('leave/update/{id}', [LeaveController::class, 'update']);
    Route::delete('leave/destroy/{id}', [LeaveController::class, 'destroy']);
    Route::get('overtime', [OvertimeController::class, 'index']);
    Route::get('overtime/show/{id}', [OvertimeController::class, 'show']);
    Route::put('overtime/update/{id}', [OvertimeController::class, 'update']);
    Route::post('overtime/store', [OvertimeController::class, 'store']);
    Route::delete('overtime/destroy/{id}', [OvertimeController::class, 'destroy']);

    Route::get('attendance', [AttendanceController::class, 'index']);
    Route::get('attendance/show/{id}', [AttendanceController::class, 'show']);
    Route::put('attendance/update/{id}', [AttendanceController::class, 'update']);
    Route::post('attendance/store', [AttendanceController::class, 'store']);
    Route::delete('attendance/destroy/{id}', [AttendanceController::class, 'destroy']);

    Route::get('shift', [ShiftController::class, 'index']);
    Route::post('company/shift/store', [ShiftController::class, 'store']);
    Route::get('company/shift/show/{id}', [ShiftController::class, 'show']);
    Route::put('company/shift/update/{id}', [ShiftController::class, 'update']);
    Route::put('company/shift/updateStatus/{id}', [ShiftController::class, 'updateStatus']);
    Route::delete('company/shift/destroy/{id}', [ShiftController::class, 'destroy']);
    Route::get('company/unchecked', [CompanyController::class, 'unchecked']);

    Route::get('company', [CompanyController::class, 'index']);
    Route::get('company/show/{id}', [CompanyController::class, 'show']);
    Route::put('company/update/{id}', [CompanyController::class, 'update']);
    Route::delete('company/delete/{id}', [CompanyController::class, 'destroy']);
    Route::get('company/overtime', [CompanyController::class, 'overtime']);
    Route::get('company/leave', [CompanyController::class, 'leave']);
    Route::get('company/user', [UserController::class, 'getUsersByCompanyId']);
    Route::get('company/lateCheckin', [CompanyController::class, 'lateCheckin']);
    Route::get('company/manager', [CompanyController::class, 'getManagerCompany']);
    Route::get('company/employee', [CompanyController::class, 'employee']);
    
    Route::get('department', [DepartmentController::class, 'index']);
    Route::post('department/store', [DepartmentController::class, 'store']);
    Route::get('department/show/{id}', [DepartmentController::class, 'show']);
    Route::put('department/update/{id}', [DepartmentController::class, 'update']);
    Route::delete('department/destroy/{id}', [DepartmentController::class, 'destroy']);

    Route::get('company/department/{id}', [CompanyController::class, 'getDepartment']);
    Route::get('company/shift/{id}', [CompanyController::class, 'getShift']);
    Route::get('company/shift', [CompanyController::class, 'getShift']);

    Route::get('home/user/statistic', [StatisticController::class, 'statisticUserMonth']);
    Route::get('home/company/statistic', [StatisticController::class, 'statisticCompany']);
    Route::get('home/user/timeWorkingDate', [StatisticController::class, 'statisticTimeWorkingDate']);
});
Route::get('refresh-token',[UserController::class,'refreshToken']);


Route::prefix('admins')->group(function () {
    Route::post('auth/login', [AuthController::class, 'login']);
    
    Route::get('dashboard', [DashboardController::class, 'getDashBoard']);
    Route::get('user/show/{id}', [UserController::class, 'showById']);
    Route::get('user', [UserController::class, 'getAllUser']);
    Route::put('user/update/{id}', [UserController::class, 'updateUserByAdmin']);
    Route::get('admin', [AdminController::class, 'index']);
    // Route Admin
    Route::get('settings', [SettingController::class, 'index']);
    Route::get('settings', [SettingController::class, 'index'])->name('setting-index');
    Route::get('settings/show/{id}', [SettingController::class, 'show'])->name('setting-show');
    Route::post('settings/store', [SettingController::class, 'store'])->name('setting-store');
    Route::put('settings/update/{id}', [SettingController::class, 'update'])->name('setting-update');
    Route::delete('settings/destroy/{id}', [SettingController::class, 'destroy'])->name('setting-destroy');
    
    Route::get('roles', [RoleController::class, 'index']);
    Route::get('admin', [AdminController::class, 'index'])->name('admin-index');
    Route::get('admin/show/{id}', [AdminController::class, 'show'])->name('admin-show');
    Route::post('admin/store', [AdminController::class, 'store'])->name('admin-store');
    Route::put('admin/update/{id}', [AdminController::class, 'update'])->name('admin-update');
    Route::delete('admin/destroy/{id}', [AdminController::class, 'destroy'])->name('admin-destroy');
    Route::put('admin/updateStatus/{id}', [AdminController::class, 'updateStatus'])->name('admin-updateStatus');
    // Route Role
    Route::get('roles', [RoleController::class, 'index'])->name('role-index');
    Route::get('roles/show/{id}', [RoleController::class, 'show'])->name('role-show');
    Route::post('roles/store', [RoleController::class, 'store'])->name('role-store');
    Route::put('roles/update/{id}', [RoleController::class, 'update'])->name('role-update');
    Route::delete('roles/destroy/{id}', [RoleController::class, 'destroy'])->name('role-destroy');
});
// Route::group(['middleware' => ['jwt.verify', 'permision.verify', 'auth:web-admin']], function () {
//    Route::get('auth/logout', [AuthController::class, 'logout'])->withoutMiddleware(['permision.verify']);
//     Route::put('auth/changePassword/{id}', [AuthController::class, 'changePassword'])->name('auth-changePassword');


//         // Route Users
//         Route::get('users', [UsersController::class, 'index'])->name('users-index');
//         Route::get('users/show/{id}', [UsersController::class, 'show'])->name('users-show');
//         Route::post('users/store', [UsersController::class, 'store'])->name('users-store');
//         Route::put('users/update/{id}', [UsersController::class, 'update'])->name('users-update');
//         Route::post('users/createUserWithNumberPhoneAndActiveCode', [UsersController::class, 'createUserWithNumberPhoneAndActiveCode'])->name('users-createUserWithNumberPhoneAndActiveCode');

//         //Route DashBoard


//         // Route Permission
//         Route::get('permissions', [PermissionController::class, 'index'])->name('permission-index');
//         // Route User Test
//     });
// });