<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ChildCaregory extends Model
{
    //
    protected $fillable = [
        'title','category_id'
    ];

    public function category()
    {
        return $this->belongsTo('App\Models\Category');
    }
}
