<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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
Route::group(['middleware' => ['role:admin']], function () {
    //
    Route::post('/category/create', 'ApiCategoryController@store')->middleware('auth:api');
    Route::post('/category/edit/{id}', 'ApiCategoryController@update')->middleware('auth:api');
    Route::post('/category/delete/{id}', 'ApiCategoryController@destroy')->middleware('auth:api');
    
});

Route::post('/register', 'ApiUserController@register');
Route::post('/login', 'ApiUserController@login');
Route::post('/user', 'ApiUserController@userInfo')->middleware('auth:api');
Route::post('/user/role', 'ApiUserController@role')->middleware('auth:api');
Route::post('/user/edit/{id}', 'ApiUserController@update')->middleware('auth:api');
Route::post('/logout', 'ApiUserController@logout')->middleware('auth:api');
Route::post('/user/history', 'ApiUserController@buyinghistory')->middleware('auth:api');


Route::get('/category', 'ApiCategoryController@index');

Route::get('/shoe/showall', 'ApiShoeController@showall');
Route::post('/shoe/show/{id}', 'ApiShoeController@show');
Route::get('/shoe', 'ApiShoeController@index');
Route::get('/shoe/search', 'ApiShoeController@search');
Route::post('/shoe/create', 'ApiShoeController@store')->middleware('auth:api');
Route::post('/shoe/edit/{id}', 'ApiShoeController@update')->middleware('auth:api');
Route::post('/shoe/delete/{id}', 'ApiShoeController@destroy')->middleware('auth:api');


Route::post('/order/create', 'ApiOrderController@store')->middleware('auth:api');
Route::post('/order/detail/{id}', 'ApiOrderController@detail')->middleware('auth:api');

Route::post('/image/create', 'ApiImageController@store');
Route::get('/image/{id}', 'ApiImageController@show')->middleware('auth:api');
Route::post('/image/edit/{id}', 'ApiImageController@update')->middleware('auth:api');
Route::post('/image/delete/{id}', 'ApiImageController@destroy')->middleware('auth:api');

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
