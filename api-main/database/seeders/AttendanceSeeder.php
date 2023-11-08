<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AttendanceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
            DB::table('attendances')->insert([
                'user_id' => '2',
                'company_id' => '1',
                'shift_id' => '1' ,
                'time_checkin' => "2023-08-22 08:01:23",
                'time_checkout' => "2023-08-22 17:31:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
            DB::table('attendances')->insert([
                'user_id' => '2',
                'company_id' => '1',
                'shift_id' => '2' ,
                'time_checkin' => "2023-08-23 07:58:23",
                'time_checkout' => "2023-08-23 17:29:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
        
            DB::table('attendances')->insert([
                'user_id' => '1',
                'company_id' => '2',
                'shift_id' => '1' ,
                'time_checkin' => "2023-08-22 07:59:23",
                'time_checkout' => "2023-08-22 16:31:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
            DB::table('attendances')->insert([
                'user_id' => '1',
                'company_id' => '2',
                'shift_id' => '1' ,
                'time_checkin' => "2023-08-23 08:01:23",
                'time_checkout' => "2023-08-23 17:31:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
            DB::table('attendances')->insert([
                'user_id' => '3',
                'company_id' => '3',
                'shift_id' => '1' ,
                'time_checkin' => "2023-08-22 07:48:23",
                'time_checkout' => "2023-08-22 17:30:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
            DB::table('attendances')->insert([
                'user_id' => '3',
                'company_id' => '3',
                'shift_id' => '2' ,
                'time_checkin' => "2023-08-22 07:01:23",
                'time_checkout' => "2023-08-22 16:31:22",
                'duration' => "04:30:00",
                'month' => random_int(1,12),
                'status_code' => rand(1,3),
                'type_checkin' => 1,
                'type_work' => 1,
                'reason' => "I feel so tired"
            ]);
    }
}
