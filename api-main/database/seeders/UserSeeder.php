<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'email' => 'congnguyenthanh@gmail.com',
            'password' => Hash::make('123456789'),
            'first_name' => 'Nguyen',
            'last_name' => 'Thanh Cong',
            'employee_code' => rand(0, 1000000),
            'company_id' => 1,
            'phone_number'=> '0907456147'
        ]);
        for ($i = 0; $i < 4; $i++) {
            DB::table('users')->insert([
                'email' => 'hatunglam' . $i . '@gmail.com',
                'password' => Hash::make('123456789'),
                'first_name' => 'Ha',
                'last_name' => 'Tung Lam',
                'employee_code' => rand(1000001, 2000000),
                'company_id' => $i+2,
                'phone_number'=> '0907456147'
            ]);
        }
        for ($i = 0; $i < 4; $i++) {
            DB::table('users')->insert([
                'email' => 'dovantu' . $i . '@gmail.com',
                'password' => Hash::make('123456789'),
                'first_name' => 'Do',
                'last_name' => 'Van Tu',
                'employee_code' => rand(2000001, 3000000),
                'company_id' => null,
                'phone_number'=> '0907456147'

            ]);
        }

    }
}