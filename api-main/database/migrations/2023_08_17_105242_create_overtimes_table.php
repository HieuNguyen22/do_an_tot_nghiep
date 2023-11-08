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
        Schema::create('overtimes', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId('user_id')->nullable();
            $table->foreignId('company_id')->nullable();
            $table->foreignId('to_approve_id')->nullable();
            $table->foreignId('approve_id')->nullable();
            $table->timestamp('time_start')->nullable();
            $table->timestamp('time_end')->nullable();
            $table->tinyInteger('month')->nullable();
            $table->time('duration')->nullable();
            $table->tinyInteger('status_code')->nullable()->default(1);
            $table->tinyInteger('type')->nullable()->default(1);
            $table->longText('reason')->nullable();
            $table->longText('reason_reject')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('overtimes');
    }
};