<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
Route::get('/{any}', function () {
    return file_get_contents(public_path('index.html'));
})->where('any','.*' );
