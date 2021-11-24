<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Rating;
use App\Models\Shoe;
use Illuminate\Support\Facades\DB;

class ApiRatingController extends Controller
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
        //
        $matchThese = ['category_id' => $request->get('user_id'), 'shoe_id' => $request->get('shoes_id')];
        $user = Rating::where($matchThese)->first();
        if ($user == null) {
            // if(is_int($request->get('rating'))){
            //     return response()->json("string");
            // }
            $product = new Rating([
                'shoe_id' => $request->get('shoes_id'),
                'category_id' => $request->get('user_id'),  
                'rating' => $request->get('rating'),  
            ]);
            $product->save();
        }
        else{
            $user->rating = $request->get('rating');
            $user->save();
        }
        $shoe = Shoe::find($request->get('shoes_id'));
        $shoe_ratings = Rating::distinct('shoes_id')->where('shoe_id','=',$request->get('shoes_id'))->get();
        $shoe->rating = $shoe_ratings->avg('rating');
        $shoe->save();
        return response()->json($shoe->rating);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request)
    {
        $matchThese = ['category_id' => $request->id, 'shoe_id' => $request->get('shoes_id')];
        $user = Rating::where($matchThese)->first();
        return response()->json($user);
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
