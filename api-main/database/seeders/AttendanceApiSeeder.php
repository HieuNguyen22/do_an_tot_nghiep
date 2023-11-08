<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AttendanceApiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->call([
            UserSeeder::class,
            CompanySeeder::class,
            ShiftSeeder::class,
            DepartmentSeeder::class,
            LeaveSeeder::class,
            OvertimeSeeder::class,
            AttendanceSeeder::class
        ]);
    }
}