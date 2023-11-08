<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LeaveSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i < 10; $i++)
            DB::table('leaves')->insert([
                'user_id' => $i + 1,
                'company_id' => 1,
                'time_start' => '2023-08-15 14:28:44',
                'time_end' => '2023-11-30 13:00:00',
                'duration' => '04:05:00',
                'status_code' => random_int(1, 2),
                'to_approve_id' => 1,
                'type' => random_int(1, 2),
            ]);
    }
}