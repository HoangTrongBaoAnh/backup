<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use App\Models\Shoe;

class ApiShoeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $categories = request()->input('categories', []);
        $prices = request()->input('prices', []);
        $orders = request()->input('orders');
        $child = request()->input('child', []);
        //$posts = Shoe::latest()->paginate(9);
        // $products = Shoe::withFilters(
        //     request()->input('prices', []),
        //     request()->input('categories', []),
            
        // )->latest()->paginate(9);

        $test = Shoe::when(count($categories), function ($query) use ($categories){
            $query->whereIn('category_id', $categories);
        })->when(count($child), function ($query) use ($child){
            $query->whereIn('childcategory_id', $child);
        })
        ->when(count($prices), function ($query) use ($prices){
            $query->where(function ($query) use ($prices) {
                $query->when(in_array(0, $prices), function ($query) {
                        $query->orWhere('price', '<', '5000');
                    })
                    ->when(in_array(1, $prices), function ($query) {
                        $query->orWhereBetween('price', ['5000', '10000']);
                    })
                    ->when(in_array(2, $prices), function ($query) {
                        $query->orWhereBetween('price', ['10000', '50000']);
                    })
                    ->when(in_array(3, $prices), function ($query) {
                        $query->orWhere('price', '>', '50000');
                    });
            });
        })
        ->when($orders != "",function ($query) use ($orders) {
            $query->when($orders == 0, function ($query) {
                    $query->latest();
                })
                ->when($orders == 1, function ($query) {
                    $query->orderBy('title', 'asc');
                })->when($orders == 2, function ($query) {
                    $query->oldest();
                });
        })->paginate(9);
        return response()->json($test);
    }

    public function showall()
    {
        $user = Shoe::with('category')->get();
        return response()->json($user);
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
        $filename = '';
        if ($request->hasFile('picture')) {
            $avatar = $request->file('picture');
            $filename = time() . '.' . $avatar->getClientOriginalExtension();
            $destinationPath = public_path('/images');
            $avatar->move($destinationPath, $filename);
            //$this->save();
        }
        //$product = new Shoe();
        $product = new Shoe([
            'title' => $request->get('title'),
            'content' => $request->get('content'),  
            'picture' => $filename,
            //'childcategory_id' => $request->get('child_category'),
            'price' => 12,  
        ]);

        if($request->input("category") != null){
            $product->category_id = $request->category;
            $product->childcategory_id = $request->child_category;
        }
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
        $product = Shoe::find($id);
        return response()->json($product);
    }

    public function search(Request $request)
    {
        $name = $request->get('name');
        //$aaa = "aaaa";
        $product = Shoe::where('title', 'like', "%{$name}%")->get();
        return response()->json($product);
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
        $product = Shoe::find($id);
        $filename = '';
        if ($request->hasFile('picture')) {
            $avatar = $request->file('picture');
            $filename = time() . '.' . $avatar->getClientOriginalExtension();
            $destinationPath = public_path('/images');
            $avatar->move($destinationPath, $filename);
            $product->picture = $filename;
        }

        if($request->input("category") != null){
            $product->category_id = $request->category;
            $product->childcategory_id = $request->child_category;
        }

        $product->content = $request->content;
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
        $res = Shoe::destroy($id);
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
