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
        Schema::create('leaves', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId('user_id')->nullable();
            $table->foreignId('company_id')->nullable();
            $table->foreignId('to_approve_id')->nullable();
            $table->foreignId('approve_id')->nullable()->nullable();
            $table->timestamp('time_start')->nullable();
            $table->timestamp('time_end')->nullable();
            $table->time('duration')->nullable();
            $table->tinyInteger('month')->nullable();
            $table->tinyInteger('status_code')->default(1)->nullable();
            $table->tinyInteger('type')->default(1)->nullable();
            $table->longText('reason')->nullable();
            $table->longText('reason_reject')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('leaves');
    }
};