<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ShiftSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 0; $i < 3; $i++) {
            DB::table('shifts')->insert([
                'company_id' => $i + 1,
                'time_start' => '08:00:00',
                'time_end' => '12:00:00',
                'duration' => '04:00:00',
                'status_code' => 1,
                'type' => 1,
                'name' => 'Ca sang'
            ]);
            DB::table('shifts')->insert([
                'company_id' => $i + 1,
                'time_start' => '13:30:00',
                'time_end' => '17:30:00',
                'duration' => '04:00:00',
                'status_code' => 1,
                'type' => 1,
                'name' => 'Ca chieu'
            ]);
        }
    }
}