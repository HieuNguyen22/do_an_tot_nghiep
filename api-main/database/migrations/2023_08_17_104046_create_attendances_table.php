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
        Schema::create('attendances', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId('user_id')->nullable()->constrained('users');
            $table->foreignId('company_id')->nullable()->constrained('companies');
            $table->foreignId('shift_id')->nullable()->constrained('shifts');
            $table->dateTime('time_checkin')->nullable();
            $table->dateTime('time_checkout')->nullable();
            $table->time('duration')->nullable();
            $table->tinyInteger('month')->nullable();
            $table->tinyInteger('type_checkin')->nullable();
            $table->tinyInteger('type_work')->nullable();
            $table->tinyInteger('status_code')->nullable();
            $table->string('reason')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('attendances');
    }
};