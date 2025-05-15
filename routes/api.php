<?php

use App\Http\Controllers\Controller;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ToursController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::post('/register', [AuthController::class, 'register']);
Route::post('/auth', [AuthController::class, 'auth']);

Route::get('/get-tours', [ToursController::class, 'getTours']);
Route::get('/get-jwt', [ToursController::class, 'getJwt']);
Route::post('/get-streams', [ToursController::class, 'getStreams']);
Route::post('/record-user-stream', [ToursController::class, 'recordUserStream']);
Route::get('/get-user-streams', [ToursController::class, 'getUserStreams']);
Route::post('/user-cancel-tour', [ToursController::class, 'userCancelTour']);

Route::get('/admin-get-streams',[ToursController::class, 'adminGetStreams']);
Route::post('/admin-delete-user-stream',[ToursController::class, 'adminDeleteUserStream']);
Route::get('/admin-get-tour-info/{id}', [ToursController::class, 'adminGetTourInfo']);

Route::get('/get-user-data', [UserController::class, 'getUserData']);
