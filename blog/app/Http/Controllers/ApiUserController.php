<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\ApiRegisterRequest;
use App\Http\Requests\ApiLoginRequest;
use App\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class ApiUserController extends Controller
{
    public function register(ApiRegisterRequest $request){
        $user = new User();
        $user->fill($request->all());
        $user->password = hash::make($request->password);
        $user->save();
        $user->assignRole('user');
        return response()->json($user);
    }

    public function login(ApiLoginRequest $request){
        if (Auth::attempt(array('email' => $request->email, 'password' => $request->password))){
            $user = User::whereEmail($request->email)->first();
            $user->token = $user->createToken('App')->accessToken;
            
            return response()->json($user);
        }
        
        return response()->json([
            'errors' => [
                'email' => ["sai ten truy cap hoac mat khau"],
                'password' => ["sai ten truy cap hoac mat khau"],
            ]
        ],401);
    }

    public function userInfo(Request $request){
        //$users = User::role('admin')->get();
        //$roles = auth('api')->user()->getRoleNames();
        return response()->json(auth('api')->user());
    }

    public function role(Request $request){
        $roles = User::with('roles')->get();
        $user = $roles->where('id', auth('api')->user()->id)->first();
        return response()->json($user);
    }

    public function logout(Request $request){
        $user = $request->user('api');
        $user->token()->revoke();
        return response()->json("success");
    }

    public function update($id,Request $request){
        $user = User::find($id);
        if($request->input("name") != null){
            $user->name = $request->name;
        }

        if($request->hasFile("picture")){
            // $image = $request->file('picture'); //get the file
            // $name = time().'.'.$image->getClientOriginalExtension(); //get the  file extention
            // $destinationPath = public_path('/images'); //public path folder dir
            // $image->move($destinationPath, $name);
            // $user->picture = $name;
            $avatar = $request->file('picture');
            $filename = time() . '.' . $avatar->getClientOriginalExtension();
            $destinationPath = public_path('/images');
            $result = cloudinary()->upload($avatar->getRealPath(),[
                'folder' => 'uploads',
                'transformation' => [
                          'width' => 400,
                          'height' => 400
                 ]
                ]);
            $user->picture =$result->getSecurePath();
        }

        $user->save();
        return response()->json($user);
    }

    public function buyinghistory(Request $request){
        $user = $request->user('api');
        $history = DB::table('users')
        ->join('orders', 'users.id', '=', 'orders.user_id')
        ->where('users.id', '=', $user->id)
        ->get();;

        return response()->json($history);
    }
}
