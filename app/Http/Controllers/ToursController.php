<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Tymon\JWTAuth\Facades\JWTAuth;

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
        $id_stream = $request->input('id_tour');
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
            return response()->json(['Ошибка авторизации' => $payload['err']]);
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

    public function adminGetTourInfo($id){
        $id_tour = $id;
        $tourInfo = DB::select('SELECT * FROM tours WHERE id_tour = 2', [$id_tour]);
        $streams = DB::select('');
        return response()->json(['id'=>$id_tour]);
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
