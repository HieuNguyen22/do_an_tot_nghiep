<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ZoneSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('zones')->insert([
            'name' => 'Executive office zone',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Membrane house zone for growing vegetables',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Greenhouse zone for growing vegetables',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Seedling nursery zone',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Warehouse zone',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Processing - packaging houses zone',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Breakroom zone for workers',
            'description' => '',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Overall infrastructure system',
            'description' => '',
            'status' => 1,
        ]);
    }
}
