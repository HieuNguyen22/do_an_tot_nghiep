<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class AddPermissionSeeder extends PermissionSeeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $permissions = [
            // User Test
            ['name' => 'userTest-resetDataUserTest', 'lable' => 'resetDataUserTest', 'group' => 'userTest'],

            // Log bonus gift code
            ['name' => 'logBonusGiftCode-index', 'lable' => 'index', 'group' => 'logBonusGiftCode'],
        ];

        foreach ($permissions as $permission) {
            Permission::create($permission);
        }

        // ReSync permission and role
        $this->ReSyncPermission();
    }
}
