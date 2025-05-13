<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;

class UserController extends Controller
{
    private function getPayloadFromToken()
    {
        try {
            $token = JWTAuth::parseToken();
            $payload = $token->getPayload();

            // $id_user = $payload->get('roles', []);
            // $roles = $payload->get('roles', []);
            return $payload; // Всё ок
        } catch (\Exception $e) {
            return ['err' => 'Ошибка авторизации: ' . $e->getMessage()];
        }
    }
    public function getUserData(){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['msg' => $payload['err']],401);
        }
        $id_user = $payload->get('sub');
        $user = DB::select('SELECT * FROM users WHERE id_user = ?',[$id_user]);
        
        return response()->json(["user"=>$user[0]]);
    }
}
