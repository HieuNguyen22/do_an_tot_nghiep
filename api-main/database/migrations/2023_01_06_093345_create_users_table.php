<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string("email")->unique();
            $table->integer('company_id')->nullable();
            $table->string('employee_code')->nullable();
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string("address")->nullable();
            $table->string("password")->nullable();
            $table->string('phone_number')->nullable();
            $table->integer('status_code')->nullable()->default(1);
            $table->integer('type_login')->nullable();
            $table->integer('type_work')->nullable();
            $table->integer('type_shift')->nullable();
            $table->integer('department_id')->nullable();
            $table->integer('role_code')->nullable();
            $table->longText("zip_code")->nullable();
            $table->longText("user_name")->nullable();
            $table->integer("platform")->default(0);
            $table->double("version")->default(0);
            $table->string("country_code")->nullable();
            $table->string("ip")->nullable();
            $table->string("agent")->nullable();
            $table->tinyInteger("status")->default(1);
            $table->longText("refresh_token")->nullable();
            $table->integer('shift_id')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}