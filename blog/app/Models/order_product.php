<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class order_product extends Model
{
    protected $fillable = [
        'order_id','product_id','quantity'
    ];
}
