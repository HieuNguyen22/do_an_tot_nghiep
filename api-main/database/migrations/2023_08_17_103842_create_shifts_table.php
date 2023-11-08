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
        Schema::create('shifts', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->foreignId('company_id')->nullable()->constrained('companies');
            $table->string('name')->nullable();
            $table->time('time_start')->nullable();
            $table->time('time_end')->nullable();
            $table->time('duration')->nullable();
            $table->tinyInteger('status_code')->default(1)->nullable();
            $table->tinyInteger('type')->default(1)->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('shifts');
    }
};