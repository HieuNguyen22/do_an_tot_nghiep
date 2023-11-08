<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('attendances', function (Blueprint $table) {
            $table->string('ip_checkin')->nullable();
            $table->string('ip_checkout')->nullable();
            $table->double('latitude_checkin')->nullable();
            $table->double('longitude_checkin')->nullable();
            $table->double('latitude_checkout')->nullable();
            $table->double('longitude_checkout')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('attendances', function (Blueprint $table) {
            //
        });
    }
};
