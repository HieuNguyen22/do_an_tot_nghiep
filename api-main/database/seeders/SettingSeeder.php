<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SettingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('settings')->insert([
            'name' => 'live_count_max',
            'value' => 5,
            'module' => 'home',
            'type' => 1,
            'position' => 1,
            'depcription' => ''
        ]);
        DB::table('settings')->insert([
            'name' => 'live_minutes_addition',
            'value' => 15,
            'module' => 'home',
            'type' => 1,
            'position' => 2,
            'depcription' => ''
        ]);
        DB::table('settings')->insert([
            'name' => 'level_count_max_ring',
            'value' => 10,
            'module' => 'home',
            'type' => 1,
            'position' => 3,
            'depcription' => ''
        ]);
        DB::table('settings')->insert([
            'name' => 'level_count_ring_hit_win',
            'value' => 5,
            'module' => 'home',
            'type' => 1,
            'position' => 4,
            'depcription' => ''
        ]);
    }
}
