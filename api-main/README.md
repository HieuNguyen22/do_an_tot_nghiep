<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400"></a></p>

## Project information

-   Php 8.2.30
-   Laravel 10

## Run with composer install error SSL/TLS

-   composer config -g -- disable-tls true

## Build Project

-   composer install
-   php artisan key:generate
-   php artisan migrate
-   php artisan jwt:secret

## Seed Database

    php artisan db:seed --class=DatabaseSeeder
    php artisan db:seed --class=AttendanceApiSeeder

## Gennerate swagger

    php artisan l5-swagger:generate
    http://127.0.0.1:8000/api/documentation#/
