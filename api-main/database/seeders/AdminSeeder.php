<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $admin = \App\Models\Admin::factory()->create([
            'name' => 'Admin',
            'email' => 'admin@devfast.us',
            'password' => Hash::make('admin@devfast.us'),
            'status' => rand(0, 1),
        ]);
        $admin->assignRole([1]);

        $admin = \App\Models\Admin::factory()->create([
            'name' => 'Chuongdt',
            'email' => 'chuongdt.dev@gmail.com',
            'password' => Hash::make('chuongdt.dev@gmail.com'),
            'status' => rand(0, 1),
        ]);
        $admin->assignRole([2]);
    }
}