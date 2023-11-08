<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OvertimeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 0; $i < 10; $i++) {
            DB::table('overtimes')->insert([
                'user_id' => $i + 2,
                'company_id' => 1,
                'to_approve_id' => 1,
                'time_start' => '2023-08-10 17:42:30',
                'time_end' => '2023-08-10 20:42:30',
                'duration' => '99:42:23',
                'status_code' => random_int(1, 2),
                'type' => random_int(1, 2)
            ]);
        }
    }
}