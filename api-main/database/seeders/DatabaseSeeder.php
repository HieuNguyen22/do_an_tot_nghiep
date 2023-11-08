<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            PermissionSeeder::class,
            SettingSeeder::class,
            RoleSeeder::class,
            AdminSeeder::class,
            UserSeeder::class,
            CompanySeeder::class,
            ShiftSeeder::class,
            DepartmentSeeder::class,
            LeaveSeeder::class,
            OvertimeSeeder::class
        ]);
    }
}