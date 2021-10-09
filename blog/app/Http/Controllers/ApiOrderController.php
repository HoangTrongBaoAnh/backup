<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\order_product;
use Illuminate\Support\Facades\DB;

class ApiOrderController extends Controller
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
        $product = new Order([
            'user_id' => $request->get('user_id'),
            'total' => $request->get('total'),  
        ]);
        $product->save();
        foreach(json_decode($request->input('cart')) as $items){
            $order_product = new order_product([
                'order_id' => $product->id,
                'product_id' => $items->id,
                'quantity' => $items->quantity,  
            ]);

            $order_product->save();
        }


        
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
    }

    public function detail($id)
    {
        $order = DB::table('order_products')
        ->join('orders', 'order_products.order_id', '=', 'orders.id')
        ->join('shoes', 'shoes.id', '=', 'order_products.product_id')
        ->where('orders.id', '=', $id)
        ->get();
        return response()->json($order);
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
