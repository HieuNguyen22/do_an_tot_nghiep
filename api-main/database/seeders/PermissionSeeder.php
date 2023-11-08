<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;


class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = [
            // Auth
            ['name' => 'auth-changePassword', 'lable' => 'changePassword', 'group' => 'auth'],

            // Permission
            ['name' => 'permission-index', 'lable' => 'index', 'group' => 'permission'],

            // Role
            ['name' => 'role-index', 'lable' => 'index', 'group' => 'role'],
            ['name' => 'role-show', 'lable' => 'show', 'group' => 'role'],
            ['name' => 'role-store', 'lable' => 'store', 'group' => 'role'],
            ['name' => 'role-update', 'lable' => 'update', 'group' => 'role'],
            ['name' => 'role-delete', 'lable' => 'delete', 'group' => 'role'],

            // Admin
            ['name' => 'admin-index', 'lable' => 'index', 'group' => 'admin'],
            ['name' => 'admin-show', 'lable' => 'show', 'group' => 'admin'],
            ['name' => 'admin-store', 'lable' => 'store', 'group' => 'admin'],
            ['name' => 'admin-update', 'lable' => 'update', 'group' => 'admin'],
            ['name' => 'admin-delete', 'lable' => 'delete', 'group' => 'admin'],

            ['name' => 'admin-updateStatus', 'lable' => 'updateStatus', 'group' => 'admin'],

            // Event
            ['name' => 'event-index', 'lable' => 'index', 'group' => 'event'],
            ['name' => 'event-show', 'lable' => 'show', 'group' => 'event'],
            ['name' => 'event-store', 'lable' => 'store', 'group' => 'event'],
            ['name' => 'event-update', 'lable' => 'update', 'group' => 'event'],
            ['name' => 'event-delete', 'lable' => 'delete', 'group' => 'event'],

            ['name' => 'event-updateStatus', 'lable' => 'updateStatus', 'group' => 'event'],

            // Zone
            ['name' => 'zone-index', 'lable' => 'index', 'group' => 'zone'],
            ['name' => 'zone-show', 'lable' => 'show', 'group' => 'zone'],
            ['name' => 'zone-store', 'lable' => 'store', 'group' => 'zone'],
            ['name' => 'zone-update', 'lable' => 'update', 'group' => 'zone'],
            ['name' => 'zone-delete', 'lable' => 'delete', 'group' => 'zone'],

            ['name' => 'zone-updateStatus', 'lable' => 'updateStatus', 'group' => 'zone'],
            ['name' => 'zone-getAllZoneBasic', 'lable' => 'getAllZoneBasic', 'group' => 'zone'],

            // Group
            ['name' => 'group-index', 'lable' => 'index', 'group' => 'group'],
            ['name' => 'group-show', 'lable' => 'show', 'group' => 'group'],
            ['name' => 'group-store', 'lable' => 'store', 'group' => 'group'],
            ['name' => 'group-update', 'lable' => 'update', 'group' => 'group'],
            ['name' => 'group-delete', 'lable' => 'delete', 'group' => 'group'],

            ['name' => 'group-updateStatus', 'lable' => 'updateStatus', 'group' => 'group'],
            ['name' => 'group-getCategoryListByGroup', 'lable' => 'getCategoryListByGroup', 'group' => 'group'],
            ['name' => 'group-getThingListByGroup', 'lable' => 'getThingListByGroup', 'group' => 'group'],
            ['name' => 'group-getHumidityAndTemperature', 'lable' => 'getHumidityAndTemperature', 'group' => 'group'],
            ['name' => 'group-getAllGroupBasic', 'lable' => 'getAllGroupBasic', 'group' => 'group'],
            ['name' => 'group-getHumidityAndTemperatureByGroupList', 'lable' => 'getHumidityAndTemperatureByGroupList', 'group' => 'group'],
            ['name' => 'group-getHumidityAndTemperatureByAllGroupList', 'lable' => 'getHumidityAndTemperatureByAllGroupList', 'group' => 'group'],

            // Category
            ['name' => 'category-index', 'lable' => 'index', 'group' => 'category'],
            ['name' => 'category-show', 'lable' => 'show', 'group' => 'category'],
            ['name' => 'category-store', 'lable' => 'store', 'group' => 'category'],
            ['name' => 'category-update', 'lable' => 'update', 'group' => 'category'],
            ['name' => 'category-delete', 'lable' => 'delete', 'group' => 'category'],

            ['name' => 'category-updateStatus', 'lable' => 'updateStatus', 'group' => 'category'],
            ['name' => 'category-getAllCategoryBasic', 'lable' => 'getAllCategoryBasic', 'group' => 'category'],

            // Thing
            ['name' => 'thing-index', 'lable' => 'index', 'group' => 'thing'],
            ['name' => 'thing-show', 'lable' => 'show', 'group' => 'thing'],
            ['name' => 'thing-store', 'lable' => 'store', 'group' => 'thing'],
            ['name' => 'thing-update', 'lable' => 'update', 'group' => 'thing'],
            ['name' => 'thing-delete', 'lable' => 'delete', 'group' => 'thing'],

            ['name' => 'thing-updateStatus', 'lable' => 'updateStatus', 'group' => 'thing'],
            ['name' => 'thing-findByZone', 'lable' => 'findByZone', 'group' => 'thing'],
            ['name' => 'thing-updateAllStatusThingByZone', 'lable' => 'updateAllStatusThingByZone', 'group' => 'thing'],
            ['name' => 'thing-updateAllStatusByGroupAndCategory', 'lable' => 'updateAllStatusByGroupAndCategory', 'group' => 'thing'],
            ['name' => 'thing-getAllThingBasic', 'lable' => 'getAllThingBasic', 'group' => 'thing'],

            // Alarm Setting
            ['name' => 'alarmSettings-index', 'lable' => 'index', 'group' => 'alarmSettings'],
            ['name' => 'alarmSettings-update', 'lable' => 'update', 'group' => 'alarmSettings'],

            // Log
            ['name' => 'log-index', 'lable' => 'index', 'group' => 'log'],
            ['name' => 'log-show', 'lable' => 'show', 'group' => 'log'],
            ['name' => 'log-store', 'lable' => 'store', 'group' => 'log'],
            ['name' => 'log-update', 'lable' => 'update', 'group' => 'log'],
            ['name' => 'log-delete', 'lable' => 'delete', 'group' => 'log'],

            // Setting
            ['name' => 'setting-index', 'lable' => 'index', 'group' => 'setting'],
            ['name' => 'setting-show', 'lable' => 'show', 'group' => 'setting'],
            ['name' => 'setting-store', 'lable' => 'store', 'group' => 'setting'],
            ['name' => 'setting-update', 'lable' => 'update', 'group' => 'setting'],
            ['name' => 'setting-delete', 'lable' => 'delete', 'group' => 'setting'],

            // Notification
            ['name' => 'notification-index', 'lable' => 'index', 'group' => 'notification'],

            // Config Bonus
            ['name' => 'configBonuses-index', 'lable' => 'index', 'group' => 'configBonuses'],
            ['name' => 'configBonuses-show', 'lable' => 'show', 'group' => 'configBonuses'],
            ['name' => 'configBonuses-store', 'lable' => 'store', 'group' => 'configBonuses'],
            ['name' => 'configBonuses-update', 'lable' => 'update', 'group' => 'configBonuses'],
            ['name' => 'configBonuses-destroy', 'lable' => 'destroy', 'group' => 'configBonuses'],

            //packageCoins
            ['name' => 'packageCoins-index', 'lable' => 'index', 'group' => 'packageCoins'],
            ['name' => 'packageCoins-show', 'lable' => 'show', 'group' => 'packageCoins'],
            ['name' => 'packageCoins-store', 'lable' => 'store', 'group' => 'packageCoins'],
            ['name' => 'packageCoins-update', 'lable' => 'update', 'group' => 'packageCoins'],
            ['name' => 'packageCoins-delete', 'lable' => 'delete', 'group' => 'packageCoins'],

            // Item
            ['name' => 'item-index', 'lable' => 'index', 'group' => 'item'],
            ['name' => 'item-show', 'lable' => 'show', 'group' => 'item'],
            ['name' => 'item-store', 'lable' => 'store', 'group' => 'item'],
            ['name' => 'item-update', 'lable' => 'update', 'group' => 'item'],
            ['name' => 'item-delete', 'lable' => 'delete', 'group' => 'item'],

            ['name' => 'item-updateStatus', 'lable' => 'updateStatus', 'group' => 'item'],

            // Item User
            ['name' => 'itemUser-index', 'lable' => 'index', 'group' => 'itemUser'],
            ['name' => 'itemUser-show', 'lable' => 'show', 'group' => 'itemUser'],
            ['name' => 'itemUser-store', 'lable' => 'store', 'group' => 'itemUser'],
            ['name' => 'itemUser-update', 'lable' => 'update', 'group' => 'itemUser'],

            // Users
            ['name' => 'users-index', 'lable' => 'index', 'group' => 'users'],
            ['name' => 'users-show', 'lable' => 'show', 'group' => 'users'],
            ['name' => 'users-store', 'lable' => 'store', 'group' => 'users'],
            ['name' => 'users-update', 'lable' => 'update', 'group' => 'users'],
            ['name' => 'users-destroy', 'lable' => 'destroy', 'group' => 'users'],
            ['name' => 'users-createUserWithNumberPhoneAndActiveCode', 'lable' => 'createUserWithNumberPhoneAndActiveCode', 'group' => 'users'],

            //ItemList
            ['name' => 'item-itemList', 'lable' => 'itemList', 'group' => 'item'],

            //PackageCoinsList
            ['name' => 'packageCoins-packageCoinsList', 'lable' => 'packageCoinsList', 'group' => 'packageCoins'],

            //ItemListByUsers
            ['name' => 'itemListUsers-listByUsers', 'lable' => 'listByUsers', 'group' => 'itemListUsers'],

            //UseItem
            ['name' => 'useItem-useItem', 'lable' => 'useItem', 'group' => 'useItem'],


            // UserLevels
            ['name' => 'userLevels-index', 'lable' => 'index', 'group' => 'userLevels'],
            ['name' => 'userLevels-show', 'lable' => 'show', 'group' => 'userLevels'],

            // Transcation
            ['name' => 'transcation-index', 'lable' => 'index', 'group' => 'transcation'],
            ['name' => 'transcation-show', 'lable' => 'show', 'group' => 'transcation'],

            // UserBattleSumary
            ['name' => 'userBattleSumary-index', 'lable' => 'index', 'group' => 'userBattleSumary'],

            //GetDashBoard
            ['name' => 'dashboard-index', 'lable' => 'index', 'group' => 'dashboard'],

            // Levels
            ['name' => 'levels-index', 'lable' => 'index', 'group' => 'levels'],
            ['name' => 'levels-show', 'lable' => 'show', 'group' => 'levels'],
            ['name' => 'levels-store', 'lable' => 'store', 'group' => 'levels'],
            ['name' => 'levels-update', 'lable' => 'update', 'group' => 'levels'],
            ['name' => 'levels-destroy', 'lable' => 'destroy', 'group' => 'levels'],

            // Gift Code
            ['name' => 'giftCode-index', 'lable' => 'index', 'group' => 'giftCode'],
            ['name' => 'giftCode-show', 'lable' => 'show', 'group' => 'giftCode'],
            ['name' => 'giftCode-store', 'lable' => 'store', 'group' => 'giftCode'],
            ['name' => 'giftCode-update', 'lable' => 'update', 'group' => 'giftCode'],
            ['name' => 'giftCode-destroy', 'lable' => 'destroy', 'group' => 'giftCode'],

            // Message
            ['name' => 'message-index', 'lable' => 'index', 'group' => 'message'],
            ['name' => 'message-show', 'lable' => 'show', 'group' => 'message'],
            ['name' => 'message-store', 'lable' => 'store', 'group' => 'message'],
            ['name' => 'message-update', 'lable' => 'update', 'group' => 'message'],
            ['name' => 'message-destroy', 'lable' => 'destroy', 'group' => 'message'],

            //Archiment User
            ['name' => 'archimentUser-index', 'lable' => 'index', 'group' => 'archimentUser'],

            //Archiment
            ['name' => 'archiment-index', 'lable' => 'index', 'group' => 'archiment'],
            ['name' => 'archiment-show', 'lable' => 'show', 'group' => 'archiment'],
            ['name' => 'archiment-store', 'lable' => 'store', 'group' => 'archiment'],
            ['name' => 'archiment-update', 'lable' => 'update', 'group' => 'archiment'],
            ['name' => 'archiment-destroy', 'lable' => 'destroy', 'group' => 'archiment'],

            //TipMessage
            ['name' => 'tipMessage-index', 'lable' => 'index', 'group' => 'tipMessage'],
            ['name' => 'tipMessage-show', 'lable' => 'show', 'group' => 'tipMessage'],
            ['name' => 'tipMessage-store', 'lable' => 'store', 'group' => 'tipMessage'],
            ['name' => 'tipMessage-update', 'lable' => 'update', 'group' => 'tipMessage'],
            ['name' => 'tipMessage-destroy', 'lable' => 'destroy', 'group' => 'tipMessage'],

            //Friends
            ['name' => 'friends-index', 'lable' => 'index', 'group' => 'friends'],
            ['name' => 'friends-show', 'lable' => 'show', 'group' => 'friends'],
            ['name' => 'friends-store', 'lable' => 'store', 'group' => 'friends'],
            ['name' => 'friends-update', 'lable' => 'update', 'group' => 'friends'],
            ['name' => 'friends-destroy', 'lable' => 'destroy', 'group' => 'friends'],

            // Lession
            ['name' => 'lession-index', 'lable' => 'index', 'group' => 'lession'],
            ['name' => 'lession-show', 'lable' => 'show', 'group' => 'lession'],
            ['name' => 'lession-store', 'lable' => 'store', 'group' => 'lession'],
            ['name' => 'lession-update', 'lable' => 'update', 'group' => 'lession'],
            ['name' => 'lession-destroy', 'lable' => 'delete', 'group' => 'lession'],

            // Part
            ['name' => 'part-index', 'lable' => 'index', 'group' => 'part'],
            ['name' => 'part-show', 'lable' => 'show', 'group' => 'part'],
            ['name' => 'part-store', 'lable' => 'store', 'group' => 'part'],
            ['name' => 'part-update', 'lable' => 'update', 'group' => 'part'],
            ['name' => 'part-destroy', 'lable' => 'delete', 'group' => 'part'],

            // Element
            ['name' => 'element-index', 'lable' => 'index', 'group' => 'element'],
            ['name' => 'element-show', 'lable' => 'show', 'group' => 'element'],
            ['name' => 'element-store', 'lable' => 'store', 'group' => 'element'],
            ['name' => 'element-update', 'lable' => 'update', 'group' => 'element'],
            ['name' => 'element-destroy', 'lable' => 'delete', 'group' => 'element'],

            // PartElement
            ['name' => 'partElement-index', 'lable' => 'index', 'group' => 'partElement'],
            ['name' => 'partElement-show', 'lable' => 'show', 'group' => 'partElement'],
            ['name' => 'partElement-store', 'lable' => 'store', 'group' => 'partElement'],
            ['name' => 'partElement-update', 'lable' => 'update', 'group' => 'partElement'],
            ['name' => 'partElement-destroy', 'lable' => 'delete', 'group' => 'partElement'],

            // Contact
            ['name' => 'contact-index', 'lable' => 'index', 'group' => 'contact'],
            ['name' => 'contact-show', 'lable' => 'show', 'group' => 'contact'],
            ['name' => 'contact-store', 'lable' => 'store', 'group' => 'contact'],
            ['name' => 'contact-update', 'lable' => 'update', 'group' => 'contact'],
            ['name' => 'contact-destroy', 'lable' => 'delete', 'group' => 'contact'],


            // Pages
            ['name' => 'page-index', 'lable' => 'index', 'group' => 'page'],
            ['name' => 'page-show', 'lable' => 'show', 'group' => 'page'],
            ['name' => 'page-store', 'lable' => 'store', 'group' => 'page'],
            ['name' => 'page-update', 'lable' => 'update', 'group' => 'page'],
            ['name' => 'page-destroy', 'lable' => 'delete', 'group' => 'page'],
            
            // Story
            ['name' => 'story-index', 'lable' => 'index', 'group' => 'story'],
            ['name' => 'story-show', 'lable' => 'show', 'group' => 'story'],
            ['name' => 'story-store', 'lable' => 'store', 'group' => 'story'],
            ['name' => 'story-update', 'lable' => 'update', 'group' => 'story'],
            ['name' => 'story-destroy', 'lable' => 'delete', 'group' => 'story'],

            // Courses
            ['name' => 'courses-index', 'lable' => 'index', 'group' => 'courses'],
            ['name' => 'courses-show', 'lable' => 'show', 'group' => 'courses'],
            ['name' => 'courses-store', 'lable' => 'store', 'group' => 'courses'],
            ['name' => 'courses-update', 'lable' => 'update', 'group' => 'courses'],
            ['name' => 'courses-destroy', 'lable' => 'delete', 'group' => 'courses'],

            // Game Detail
            ['name' => 'gameDetail-index', 'lable' => 'index', 'group' => 'gameDetail'],
            ['name' => 'gameDetail-show', 'lable' => 'show', 'group' => 'gameDetail'],
            ['name' => 'gameDetail-store', 'lable' => 'store', 'group' => 'gameDetail'],
            ['name' => 'gameDetail-update', 'lable' => 'update', 'group' => 'gameDetail'],
            ['name' => 'gameDetail-destroy', 'lable' => 'delete', 'group' => 'gameDetail'],
            
            // Game Mini
            ['name' => 'gameMini-index', 'lable' => 'index', 'group' => 'gameMini'],
            ['name' => 'gameMini-show', 'lable' => 'show', 'group' => 'gameMini'],
            ['name' => 'gameMini-store', 'lable' => 'store', 'group' => 'gameMini'],
            ['name' => 'gameMini-update', 'lable' => 'update', 'group' => 'gameMini'],
            ['name' => 'gameMini-destroy', 'lable' => 'delete', 'group' => 'gameMini'],

            //Code
            ['name' => 'code-index', 'lable' => 'index', 'group' => 'code'],
            ['name' => 'code-show', 'lable' => 'show', 'group' => 'code'],
            ['name' => 'code-store', 'lable' => 'store', 'group' => 'code'],
            ['name' => 'code-update', 'lable' => 'update', 'group' => 'code'],
            ['name' => 'code-destroy', 'lable' => 'delete', 'group' => 'code'],
            ['name' => 'code-updateStatus', 'lable' => 'updateStatus', 'group' => 'code'],

            //Song
            ['name' => 'song-index', 'lable' => 'index', 'group' => 'song'],
            ['name' => 'song-show', 'lable' => 'show', 'group' => 'song'],
            ['name' => 'song-store', 'lable' => 'store', 'group' => 'song'],
            ['name' => 'song-update', 'lable' => 'update', 'group' => 'song'],
            ['name' => 'song-destroy', 'lable' => 'delete', 'group' => 'song'],

            //Step
            ['name' => 'step-index', 'lable' => 'index', 'group' => 'step'],
            ['name' => 'step-show', 'lable' => 'show', 'group' => 'step'],
            ['name' => 'step-store', 'lable' => 'store', 'group' => 'step'],
            ['name' => 'step-update', 'lable' => 'update', 'group' => 'step'],
            ['name' => 'step-destroy', 'lable' => 'delete', 'group' => 'step'],

            //plan
            ['name' => 'plan-index', 'lable' => 'index', 'group' => 'plan'],
            ['name' => 'plan-show', 'lable' => 'show', 'group' => 'plan'],
            ['name' => 'plan-store', 'lable' => 'store', 'group' => 'plan'],
            ['name' => 'plan-update', 'lable' => 'update', 'group' => 'plan'],
            ['name' => 'plan-destroy', 'lable' => 'delete', 'group' => 'plan'],
        ];

        foreach ($permissions as $permission) {
            Permission::create($permission);
        }
    }

    public function ReSyncPermission(){
        $allPermissionList = Permission::get()->all();
        $roleList = Role::where('name', 'Super Admin')->get()->all();
        foreach ($allPermissionList as $permission) {
            foreach ($roleList as $role) {
                $role->syncPermissions($allPermissionList);
            }
            $permission->syncRoles($roleList);
        }
    }
}
