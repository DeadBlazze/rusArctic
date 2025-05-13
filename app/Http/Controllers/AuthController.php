<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Tymon\JWTAuth\Facades\JWTFactory;
use Tymon\JWTAuth\Facades\JWTAuth;

class AuthController extends Controller
{
    public function register(Request $request){
        $validator = Validator::make($request->all(), [
            'fio' => ['required','regex:/^[А-Яа-яЁёA-Za-z\s\-]{1,200}$/u'],
            'email' => ['required','regex:/^[0-9A-Za-z_.+-]{1,64}@[0-9A-Za-z_-]{1,10}\.[0-9A-Za-z_-]{2,6}$/'],
            'password' => ['required','regex:/^(?=.*[.!,?])[0-9A-Za-z\s.!,?-]{8,40}$/'],
            'tel' => ['required', 'regex:/^(?:\+7|8)\d{10}$/'],
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $fio = $request->input('fio');
        $email = $request->input('email');
        $password = $request->input('password');
        $tel =  $request->input('tel');

        $userExist = DB::select('SELECT * FROM users WHERE email = ?', [$email]);

        if ($userExist) {
            return response()->json(['msg' => 'Такой пользователь уже существует'], 400);
        }

        DB::insert(
            'INSERT INTO users (fio, email, password, tel) VALUES (?, ?, ?, ?)',
            [$fio, $email, Hash::make($password), $tel]
        );
        $id_user = DB::getPdo()->lastInsertId();
        $roles = 'user';
        $payloadParam = [
            'sub' => $id_user,
            'iat' => now()->timestamp,
            'exp' => now()->addDays(3)->timestamp,
            'roles'=> $roles
        ];
        $payload = JWTFactory::customClaims($payloadParam)->make();
        $token = JWTAuth::encode($payload)->get();

        return response()->json([
            'msg' => 'Успешная регистрация',
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => '3 дня'
        ]);
    }
    public function auth(Request $request){
        $validator = Validator::make($request->all(), [
            'password' => ['required', 'regex:/^(?=.*[.!,?])[0-9A-Za-z\s.!,?-]{8,40}$/'],
            'email' => ['required', 'regex:/^[0-9A-Za-z_.+-]{1,64}@[0-9A-Za-z_-]{1,10}\.[0-9A-Za-z_-]{2,6}$/']
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = DB::select('SELECT * FROM users WHERE email = ?',
        [$request->input('email')]);

        if (!$user) {
            return response()->json(['msg' => 'Такого пользователя нет'], 401);
        }

        $user = $user[0];
        $id_user = $user->id_user;
        if (!Hash::check($request->input('password'), $user->password)) {
            return response()->json(['msg' => 'Неверный email или пароль'], 401);
        }

        $roles = [];
        if($user->is_admin){
            $roles = ['admin'];
        }
        else{
            $roles = ['user'];
        }
        $payloadParam = [
            'sub' => $id_user,
            'iat' => now()->timestamp,
            'exp' => now()->addDays(3)->timestamp,
            'roles' => $roles
        ];
        $payload = JWTFactory::customClaims($payloadParam)->make();
        $token = JWTAuth::encode($payload)->get();
        return response()->json([
            'msg' => 'Успешный вход',
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => '3 дня',
            'roles' => $roles
        ]);
    }
}
