<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DepartmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 0; $i < 3; $i++) {
            DB::table('departments')->insert([
                'company_id' => $i + 1,
                'status_code' => random_int(1, 2),
                'name' => 'Dev',
                'manager_id' => $i + 1
            ]);
            DB::table('departments')->insert([
                'company_id' => $i + 1,
                'status_code' => random_int(1, 2),
                'name' => 'Marketing',
                'manager_id' => $i + 2
            ]);
        }
    }
}