<?php

namespace Database\Seeders;

use App\Http\Services\CompanyService;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CompanySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $companyService = new CompanyService();

        DB::table('companies')->insert([
            'name' => 'Valve Corporation',
            'representative_name' => 'Gabe Newell',
            'company_code' => $companyService->generateCode(),
            'address' => 'Washington, US',
            'category_code' => random_int(1, 10),
            'status_code' => random_int(1, 3),
            'latitude' => random_int(-90, 90),
            'longitude' => random_int(-180, 180),
            'type_check_login' => random_int(1, 3),
            'type_work' => random_int(1, 3),
            'max_distance' => 50,
            'admin_id'=>1
        ]);
        DB::table('companies')->insert([
            'name' => 'Blizzard',
            'representative_name' => 'Allen Adham',
            'company_code' => $companyService->generateCode(),
            'address' => 'Silicon valley, US',
            'category_code' => random_int(1, 10),
            'status_code' => random_int(1, 3),
            'latitude' => random_int(-90, 90),
            'longitude' => random_int(-180, 180),
            'type_check_login' => random_int(1, 3),
            'type_work' => random_int(1, 3),
            'max_distance' => 100,
            'admin_id'=>2
        ]);
        DB::table('companies')->insert([
            'name' => 'Riot Entertainment',
            'representative_name' => 'Erico',
            'company_code' => $companyService->generateCode(),
            'address' => 'Silicon valley, US',
            'category_code' => random_int(1, 10),
            'status_code' => random_int(1, 3),
            'latitude' => random_int(-90, 90),
            'longitude' => random_int(-180, 180),
            'type_check_login' => random_int(1, 3),
            'type_work' => random_int(1, 3),
            'max_distance' => 150,
            'admin_id'=>3
        ]);
        for ($i = 0; $i < 100; $i++) {
            DB::table('companies')->insert([
                'name' => 'Cong ty Ma' . $i,
                'representative_name' => 'Erico',
                'company_code' => $companyService->generateCode(),
                'address' => 'Silicon valley, US',
                'category_code' => random_int(1, 10),
                'status_code' => random_int(1, 3),
                'latitude' => random_int(-90, 90),
                'longitude' => random_int(-180, 180),
                'type_check_login' => random_int(1, 3),
                'type_work' => random_int(1, 3),
                'max_distance' => 80,
                'admin_id'=>$i+4
            ]);
        }
    }
}