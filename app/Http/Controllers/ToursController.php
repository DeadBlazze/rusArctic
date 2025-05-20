<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;
use Illuminate\Support\Str;

class ToursController extends Controller
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
    public function getTours(Request $request){
        // if ($error = $this->getUserIdFromToken($request)) {
        //     return $error;
        // }
        $tours = DB::select('SELECT * FROM tours WHERE is_active = 1');
        foreach ($tours as &$tour) {
            $images = DB::select('SELECT imagePath FROM tours__images WHERE id_tour = ?', [$tour->id_tour]);
            $tour->images = array_map(fn($img) => $img->imagePath, $images);
        }
        return response()->json(
            $tours);
    }
    public function getStreams(Request $request){
        $streams = DB::select('SELECT * FROM tours__streams WHERE id_tour = ?', [$request->input('id_tour')]);
        return response()->json(
            $streams);
    }
    public function userCancelTour(Request $request){
        $id_stream = $request->input('id_stream');
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']],401);
        }
        $id_user = $payload->get('sub');
        $res = DB::delete('DELETE FROM users__streams WHERE id_user = ? AND id_stream = ?', [$id_user, $id_stream]);
        if($res){
            return response()->json(['result'=>$res],200);
        }
        else{
            return response()->json(['err'=>'Ошибка удаления'],402);
        }
    }
    public function adminGetStreams(Request $request){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['msg' => $payload['err']], 403);
        }
        $roles = $payload->get('roles',[]);
        if (!in_array('admin', $roles)) {
            return response()->json(['error' => 'Запрещённый ресурс'], 403);
        }
        $allstreams = DB::select(
        'SELECT * FROM (SELECT id_tour, description, title, duration, route, includes, price FROM tours WHERE is_active = 1) AS activeTours
                        INNER JOIN 
                            (SELECT id_tour, start_time, start_point, id_stream, StreamsUserAndTourId.id_user, fio, email, tel, timestamp FROM 
                                (SELECT id_tour, start_time, start_point, tours__streams.id_stream, id_user, timestamp FROM tours__streams
                                    INNER JOIN 
                                        (SELECT * FROM `users__streams`) AS streams
                                    ON tours__streams.id_stream = streams.id_stream) AS StreamsUserAndTourId
                            INNER JOIN users 
                            ON StreamsUserAndTourId.id_user = users.id_user) AS fullUserAndStream
                        ON activeTours.id_tour = fullUserAndStream.id_tour  
                ORDER BY `fullUserAndStream`.`timestamp` ASC');
        return response()->json( $allstreams);
    }

    public function recordUserStream(Request $request){
        $id_stream = $request->input('id_stream');
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']],401);
        }
        $id_user = $payload->get('sub');
        $streamExist = DB::select('SELECT * FROM users__streams WHERE id_stream = ? AND id_user = ?', [$id_stream, $id_user]);
        if($streamExist){
            return response()->json(['err'=>'Вы уже записаны на этот тур'], 401);
        }
        $inserting = DB::insert('INSERT INTO `users__streams` (`id_user`, `id_stream`) VALUES (?, ?)', [$id_user,$id_stream]);
        if($inserting){
            return response()->json(['Вы успешено добавлены на тур'],200);
        }
    }
    public function adminDeleteUserStream(Request $request){
        $id_stream = $request->input('id_stream');
        $id_user = $request->input('id_user');

        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']]);
        }
        $roles = $payload->get('roles',[]);
        if (!in_array('admin', $roles)) {
            return response()->json(['error' => 'Запрещённый ресурс'], 403);
        }

        $res = DB::delete('DELETE FROM users__streams WHERE id_user = ? AND id_stream = ?', [$id_user, $id_stream]);
        return response()->json(['result'=>$res]);
    }
    public function adminCreateTour(Request $request){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['msg' => $payload['err']],402);
        }
        $roles = $payload->get('roles',[]);
        if (!in_array('admin', $roles)) {
            return response()->json(['msg' => 'Запрещённый ресурс'], 403);
        }

        $files = $request->file('images');
        $jsonData = json_decode($request->input('json'), true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            return response()->json(['error' => 'Невалидный JSON'], 400);
        }
        
        $tourInsertResult = DB::insert('INSERT INTO tours (`title`, `description`, `duration`, `route`, `includes`, `price`) 
        VALUES (?, ?, ?, ?, ?, ?)', 
        [$jsonData['tourTitle'], $jsonData['tourDescription'], $duration = $jsonData['tourDuration'], 
        $route = $jsonData['tourRoute'], $jsonData['tourIncludes'], $price = $jsonData['tourPrice']]);

        $id_tour = DB::getPdo()->lastInsertId();

        foreach ($jsonData['tourStreams'] as $stream) {
            DB::insert('INSERT INTO tours__streams (`id_tour`, `start_time`, `start_point`) VALUES (?, ?, ?)', 
            [$id_tour, $stream['date'], $stream['start_point']]);
        }

        // Пример возврата или дальнейшей обработки
        foreach ($files as $file) {
            $extension = $file->getClientOriginalExtension(); // расширение без точки
            $uuidName = (string) Str::uuid() . '.' . $extension; // например: "a1b2c3d4-...-e5f6.jpg"
            
            try{
                $file->move(public_path('data'), $uuidName);
            }
            catch(\Exception $e){
                return response()->json(['msg'=>$e]);
            }
            DB::insert('INSERT INTO tours__images (`id_tour`, `imagePath`) VALUES (?, ?)', 
            [$id_tour, $uuidName]);
        }
        return response()->json(['msg'=>'Упешно']);
    }
    public function adminDeleteTour(Request $request){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']]);
        }
        $roles = $payload->get('roles',[]);
        if (!in_array('admin', $roles)) {
            return response()->json(['error' => 'Запрещённый ресурс'], 403);
        }

        $id_tour =  $request->input('id_tour');
        if($id_tour<15){
            return response()->json(['msg'=>'В данный момент основные туры удалять запрещено'], 402);
        }
        
        $images = DB::select('SELECT imagePath FROM tours__images WHERE id_tour = ?', [$id_tour]);
        
        $result = DB::delete('DELETE FROM tours WHERE id_tour = ?', [$id_tour]);
        if(!$result){
            return response()->json(['msg'=>'Ошибка удаления'], 500);
        }

        // Удаление картинок с диска
        foreach ($images as $image) {
            $imagePath = public_path('data/' . $image->imagePath);
            if (file_exists($imagePath)) {
                unlink($imagePath);
            }
        }

        return response()->json(['msg'=>'Тур успешно удалён'], 200);
    }
    public function adminEditTour(Request $request){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']], 402);
        }
        $roles = $payload->get('roles',[]);
        if (!in_array('admin', $roles)) {
            return response()->json(['error' => 'Запрещённый ресурс'], 403);
        }


        $files = $request->file('images');
        $jsonData = json_decode($request->input('json'), true);
        if (json_last_error() !== JSON_ERROR_NONE) {
            return response()->json(['error' => 'Невалидный JSON'], 400);
        }


        $streams = $jsonData['tourStreams'];
        $id_tour = $jsonData['id_tour'];
        if($id_tour<15){
            return response()->json(['msg'=>'В данный момент основные туры редактировать запрещено'], 402);
        }
        if (!$id_tour || !is_array($streams)) {
            return response()->json(['error' => 'Неверный формат данных'], 400);
        }


        // Сносим все картинки тура
        $images = DB::select('SELECT imagePath FROM tours__images WHERE id_tour = ?', [$id_tour]);
        DB::delete('DELETE FROM tours__images WHERE id_tour = ?', [$id_tour]);
        foreach ($images as $image) {
            $imagePath = public_path('data/' . $image->imagePath);
            if (file_exists($imagePath)) {
                unlink($imagePath);
            }
        }
        // Запиливаем новые картинки
        foreach ($files as $file) {
            $extension = $file->getClientOriginalExtension(); // расширение без точки
            $uuidName = (string) Str::uuid() . '.' . $extension; // например: "a1b2c3d4-...-e5f6.jpg"
            
            try{
                $file->move(public_path('data'), $uuidName);
            }
            catch(\Exception $e){
                return response()->json(['msg'=>$e], 500);
            }
            DB::insert('INSERT INTO tours__images (`id_tour`, `imagePath`) VALUES (?, ?)', 
            [$id_tour, $uuidName]);
        }


        // Собираем id_stream которые пришли
        $idsToKeep = [];
        foreach ($streams as $stream) {
            if (isset($stream['id_stream'])) {
                $idsToKeep[] = (int) $stream['id_stream'];
            }
        }

        // Удаляем потоки, которые не пришли с фронта
        if (count($idsToKeep) > 0) {
            $placeholders = implode(',', array_fill(0, count($idsToKeep), '?'));
            $params = array_merge([$id_tour], $idsToKeep);
            DB::delete("DELETE FROM tours__streams WHERE id_tour = ? AND id_stream NOT IN ($placeholders)", $params);
        } else {
            // Если не пришёл ни один id_stream — удалить все
            DB::delete("DELETE FROM tours__streams WHERE id_tour = ?", [$id_tour]);
        }

        // update или insert для каждого потока с фронта
        foreach ($streams as $stream) {
            $start_time = $stream['start_time'] ?? null;
            $start_point = $stream['start_point'] ?? null;

            if (!$start_time || !$start_point) {
                continue;
            }

            if (isset($stream['id_stream'])) {
                // UPDATE
                DB::update(
                    "UPDATE tours__streams SET start_time = ?, start_point = ? WHERE id_stream = ?",
                    [$start_time, $start_point, $stream['id_stream']]
                );
            } else {
                // INSERT
                DB::insert(
                    "INSERT INTO tours__streams (id_tour, start_time, start_point) VALUES (?, ?, ?)",
                    [$id_tour, $start_time, $start_point]
                );
            }
        }

    }
    public function getUserStreams(Request $request){
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']],401);
        }
        $id_user = $payload->get('sub');
        $currentStreams = DB::select(
                'SELECT * FROM (SELECT id_tour, description, title, duration, route, includes, price FROM tours WHERE is_active = 1) AS activeTours
        INNER JOIN 
                (SELECT id_tour, start_time, start_point, tours__streams.id_stream FROM tours__streams
            INNER JOIN 
                (SELECT id_stream FROM `users__streams` WHERE id_user = ?) AS streams 
            ON tours__streams.id_stream = streams.id_stream) AS currentStreamsAndTourId 
        ON activeTours.id_tour = currentStreamsAndTourId.id_tour;', 
        [$id_user]);

        return response()->json($currentStreams,200);
    }
    //Защищённый маршрут
    public function getJwt(Request $request){
        // $payload = $request->input('jwt');
        $payload = $this->getPayloadFromToken();
        if (isset($payload['err'])) {
            return response()->json(['Ошибка авторизации' => $payload['err']]);
        }
        // $roles = $payload->get('roles',[]);
        // if (!in_array('admin', $roles)) {
        //     return response()->json(['error' => 'Запрещённый ресурс'], 403);
        // }
        return response()->json(['success' => true, 'message' => $payload]);
    }
    
}
// return response()->json($request);
