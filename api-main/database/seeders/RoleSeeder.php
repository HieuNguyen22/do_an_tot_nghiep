<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Repositories\RoleRepository;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $roleRepository = new RoleRepository();

        $roleRepository->create([
            'name' => ['name' => "Super Admin"],
            'permissions' => ['permissions' => Permission::all('id')->toArray()]
        ]);

        $roleRepository->create([
            'name' => ['name' => "User"],
            'permissions' => ['permissions' => [5, 3]]
        ]);
    }
}
