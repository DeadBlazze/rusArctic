<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class Controller 
{
    public function show(Request $request){
        $tours = DB::select('SELECT * FROM tours');
        return response()->json([
            'message' => 'Tours data received',
            'data' => $tours
        ],200);
    }

    // $mysqli = new mysqli('localhost', 'tours', 'root', '');
    // $stmt = prpare($mysqli)
    
}
