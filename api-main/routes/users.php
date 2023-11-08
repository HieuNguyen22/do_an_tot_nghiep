<?php

use Illuminate\Support\Facades\Route;

// use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ItemController;
use App\Http\Controllers\PackageCoinsController;
use App\Http\Controllers\ItemListUsersController;
use App\Http\Controllers\UserItemController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\DailyBonusController;
use App\Http\Controllers\AdsBonusController;
use App\Http\Controllers\EventsController;
use App\Http\Controllers\UserLevelsController;
use App\Http\Controllers\LevelController;
use App\Http\Controllers\GameController;
use App\Http\Controllers\GiftCodeController;
use App\Http\Controllers\ListTipMessageController;
use App\Http\Controllers\MessagesController;
use App\Http\Controllers\UserLevelController;
use App\Http\Controllers\FriendController;
use App\Http\Controllers\PartsController;
use App\Http\Controllers\LessionsController;
use App\Http\Controllers\GameDetailController;
use App\Http\Controllers\StoryController;
use App\Http\Controllers\StepController;
use App\Http\Controllers\ElementController;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\GameMiniController;
use App\Http\Controllers\SongController;
use App\Http\Controllers\PlanController;
use App\Http\Controllers\PageController;
use App\Http\Controllers\UserAuthenticateController;
use App\Http\Middleware\MeasureExecutionTime;



/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::prefix('api/users')->group(function () {
//     //Login User
//     Route::post('login', [UserController::class, 'login']);

//     Route::post('userAuthenticate/userRegister', [UserAuthenticateController::class, 'userRegister']);
//     Route::post('userAuthenticate/userLogin', [UserAuthenticateController::class, 'userLogin']);
//     Route::post('userAuthenticate/refreshToken', [UserAuthenticateController::class, 'refreshToken']);
    
//     // Create User Play
//     Route::post('createUserPlay', [UserController::class, 'createUserPlay'])->middleware(MeasureExecutionTime::class);

//     // Route::group(['middleware' => 'usersauth'], function () {
//     Route::group(['middleware' => ['jwt.verify', 'auth:app-users', 'measureExecutionTime']], function () {
//         //Notification
//         // Route::get('notifications', [NotificationController::class, 'index'])->name('notification-index');

//         //itemList
//         // Route::get('item/itemList', [ItemController::class, 'itemList'])->name('item-itemList');

//         //packageCoinsList
//         // Route::get('packageCoins/packageCoinsList', [PackageCoinsController::class, 'packageCoinsList'])->name('packageCoins-packageCoinsList');

//         // Get item by user
//         // Route::get('userItem/getItemByUser', [UserItemController::class, 'getItemByUser'])->name('userItem-getItemByUser');

//         //Use Item
//         // Route::post('userItem/useItem', [UserItemController::class, 'useItem'])->name('userItem-useItem');

//         //dailyBonus
//         // Route::get('dailyBonus/getDailyBonusList', [DailyBonusController::class, 'getDailyBonusList'])->name('dailyBonus-getDailyBonusList');

//         //Bonus Ads for user
//         // Route::post('adsBonus/bonusForAds', [AdsBonusController::class, 'bonusForAds'])->name('adsBonus-bonusForAds');

//         //Save User Levels Result
//         // Route::post('userLevels/saveUserLevelResult', [UserLevelsController::class, 'saveUserLevelResult'])->name('userLevels-saveUserLevelResult');

//         // Retrive Gift Code
//         // Route::post('giftCode/retriveGiftCode', [GiftCodeController::class, 'retriveGiftCode'])->name('giftCode-retriveGiftCode');

//         // Buy Gold
//         // Route::post('shop/buyGold', [ShopController::class, 'buyGold'])->name('shop-buyGold');

//         // Buy Item
//         // Route::post('shop/buyItem', [ShopController::class, 'buyItem'])->name('shop-buyItem');

//         // Buy Plan
//         // Route::post('shop/buyPlan', [ShopController::class, 'buyPlan'])->name('shop-buyPlan');

//         // Game Setting
//         // Route::post('game/startGame', [GameController::class, 'startGame'])->name('game-startGame');

//         // Get Level
//         // Route::get('userLevels/getLevel', [UserLevelsController::class, 'getLevelList'])->name('userLevels-getLevel');

//         // Tip Message 
//         // Route::get('tipMessage/listTipMessage', [ListTipMessageController::class, 'listTipMessage'])->name('tipMessage-listTipMessage');

//         // Get User Info
//         Route::get('getUserInfo', [UserController::class, 'getUserInfo'])->name('user-getUserInfo');

//         //Get Level
//         // Route::get('level/getLevel', [LevelController::class, 'getLevel'])->name('level-getLevel');

//         //Get Syn User Info
//         Route::post('synUserInfo', [UserController::class, 'SynUserInfo'])->name('user-synUserInfo');

//         //Get Syn User Item List
//         // Route::post('userItem/synUserItemList', [UserItemController::class, 'synUserItemList'])->name('userItem-synUserItemList');

//         // Buy Action
//         Route::get('buyAction', [UserController::class, 'buyAction'])->name('user-buyAction');

//         // Route::get('level/getLevel', [LevelController::class, 'getLevel'])->name('level-getLevel');

//         // Route::post('userLevels/syncLevelResult', [UserLevelsController::class, 'syncLevelResult'])->name('userLevels-syncLevelResult');

//         //FriendsRequest
//         // Route::get('friends/listFriendRequest', [FriendController::class, 'listFriendRequest'])->name('friends-listFriendRequest');

//         //List Friend By User 
//         // Route::get('friends/listFriendByUser', [FriendController::class, 'listFriendByUser'])->name('friends-listFriendByUser');

//         //Accept Friend
//         // Route::post('friends/acceptFriend', [FriendController::class, 'acceptFriend'])->name('friends-acceptFriend');

//         //FriendsRequest
//         // Route::post('friends/requestFriend', [FriendController::class, 'requestFriend'])->name('friends-requestFriend');

//         //SuggestionFriend
//         // Route::get('friends/suggestionFriend', [FriendController::class, 'suggestionFriend'])->name('friends-suggestionFriend');

//         //SendGiftForFriend
//         // Route::post('friends/sendGiftForFriend', [FriendController::class, 'sendGiftForFriend'])->name('friends-sendGiftForFriend');

//         // ReceiveGiftFromFriend
//         // Route::post('friends/receiveGiftFromFriend', [FriendController::class, 'receiveGiftFromFriend'])->name('friends-receiveGiftFromFriend');

//         //Claim 2
//         // Route::get('userLevels/claim2', [UserLevelsController::class, 'claim2'])->name('userLevels-claim2');

//         //Event
//         // Route::get('events/eventsList', [EventsController::class, 'eventsList'])->name('events-eventsList');

//         //Messages
//         // Route::get('message/listMessages', [MessagesController::class, 'listMessages'])->name('message-listMessages');

//         //Part
//         // Route::get('part/getList', [PartsController::class, 'getList'])->name('part-getList');

//         //LessionS 
//         // Route::get('lession/getList', [LessionsController::class, 'getList'])->name('lession-getList');

//         //GameDetail
//         // Route::get('gameDetail/getList', [GameDetailController::class, 'getList'])->name('gameDetail-getList');

//         //GameMini
//         // Route::get('gameMini/getList', [GameMiniController::class, 'getList'])->name('gameMini-getList');

//         //Storys
//         // Route::get('story/getList', [StoryController::class, 'getList'])->name('story-getList');
//         // Route::get('story/getStory', [StoryController::class, 'getStory'])->name('story-getStory');

//         //Steps
//         // Route::get('step/getList', [StepController::class, 'getList'])->name('step-getList');

//         //Element
//         // Route::get('element/getList', [ElementController::class, 'getList'])->name('element-getList');

//         //Course  
//         // Route::get('course/getList', [CourseController::class, 'getList'])->name('course-getList');

//         //Page  
//         // Route::get('page/getList', [PageController::class, 'getList'])->name('page-getList');

//         //Course  
//         // Route::get('song/getSong', [SongController::class, 'getSong'])->name('song-getSong');

//         //Plan  
//         // Route::get('plan/getList', [PlanController::class, 'getList'])->name('plan-getList');

//         //Update profile
//         // Route::put('updateProfile', [UserController::class, 'updateProfile'])->name('user-updateProfile');
//     });
//     // });
// });
