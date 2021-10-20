<?php

namespace App\Http\Controllers;

use App\Models\ChildCaregory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiChildCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        //Shoe::with('category')->get();
        $category = ChildCaregory::with('category')->get();
        return response()->json($category);
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
        $product = new ChildCaregory([
            'title' => $request->get('title'),
            'category_id' => $request->get('category_id'),  
        ]);

        $product->save();
        return response()->json($product);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
        $history = DB::table('child_caregories')
        ->where('category_id', '=', $id)
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
        //
        $product = ChildCaregory::find($id);

        $product->title = $request->title;
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
        $res = ChildCaregory::destroy($id);
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
