<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ZoneVnSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('zones')->insert([
            'name' => 'Khu vực văn phòng điều hành',
            'description' => 'Khu vực nhà điều hành/ văn phòng chính',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Khu vực nhà màng trồng rau lấy thân lấy quả các loại',
            'description' => 'Khu vực trồng rau lấy thân lấy quả các loại, rau ngắn ngày',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Khu vực nhà kính trồng rau lấy củ',
            'description' => 'Khu vực trồng rau lấy củ các loại, rau dài ngày',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => '	Khu vực vườn ươm cây giống',
            'description' => 'Khu vực ươm/gieo hạt giống để lấy cây đem đi trồng',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Khu vực nhà kho',
            'description' => 'Khu vực nhà kho chứa sản phẩm sau khi thu hoạch',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Khu vực chế biến - đóng gói',
            'description' => 'Khu vực chế biến - đóng gói sản phẩm để đem ra thị trường',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Khu vực nhà ăn cho công nhân',
            'description' => 'Khu vực nhà ăn dành riêng cho công nhân',
            'status' => 1,
        ]);
        DB::table('zones')->insert([
            'name' => 'Hệ thống hạ tầng tổng thể',
            'description' => 'Hệ thống cấp - thoát nước tổng thể tưới cây , Hệ thống cấp điện tổng thể',
            'status' => 1,
        ]);
    }
}
