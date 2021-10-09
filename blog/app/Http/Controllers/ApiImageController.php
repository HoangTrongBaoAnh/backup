<?php

namespace App\Http\Controllers;

use App\Models\Image;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiImageController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $count = DB::table('Images')->where('product_id', '=', $request->input("id"))->count();
        $file_count = count($request->file("files"));
        if($count + $file_count <= 4){
            if($request->hasFile("files")){
                $i = 0;
                foreach($request->file("files") as $picture){
                    $image = $picture; //get the file
                    $name = time().$i.'.'.$image->getClientOriginalExtension(); //get the  file extention
                    $destinationPath = public_path('/images'); //public path folder dir
                    $image->move($destinationPath, $name);
                    $i++;
                    $img = new Image([
                        'product_id' => $request->input("id"),
                        'picture' => $name
                    ]);
                    $img->save();
                }
                return response()->json($name);  
            }
        }
        else{
            return response()->json("Dont upload over 4 images");
        }
        //return response()->json($name);  
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $history = DB::table('Images')
        ->where('product_id', '=', $id)
        ->get();

        return response()->json($history);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $product = Image::find($id);
        $filename = '';
        if ($request->hasFile('picture')) {
            $avatar = $request->file('picture');
            $filename = time() . '.' . $avatar->getClientOriginalExtension();
            $destinationPath = public_path('/images');
            $avatar->move($destinationPath, $filename);
            $product->picture = $filename;
        }

        
        $product->save();

        return response()->json($product);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $res = Image::destroy($id);
        if ($res) {
            return response()->json([
                'status' => 1,
                'msg' => 'success'
            ]);
        } else {
            return response()->json([
                'status' => 0,
                'msg' => 'fail'
            ]);
        }
        return response()->json("success");
    }
}
