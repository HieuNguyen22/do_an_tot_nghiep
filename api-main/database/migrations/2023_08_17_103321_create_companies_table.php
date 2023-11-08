<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('companies', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->string('name')->nullable();
            $table->string('representative_name')->nullable();
            $table->string('company_code')->unique()->nullable();
            $table->string('address')->nullable();
            $table->foreignId('admin_id')->nullable();
            $table->tinyInteger('category_code')->nullable()->default(1);
            $table->tinyInteger('status_code')->nullable()->default(1);
            $table->tinyInteger('type_check_login')->nullable()->default(1);
            $table->tinyInteger('type_work')->nullable()->default(1);
            $table->double('longitude')->nullable();
            $table->double('latitude')->nullable();
            $table->double('max_distance')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('companies');
    }
};