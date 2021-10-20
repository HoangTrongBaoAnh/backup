<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    //
    protected $fillable = [
        'content',
    ];

    public function shoe()
    {
        return $this->hasMany('App\Models\Shoe');
    }

    public function ChildCaregory()
    {
        return $this->hasMany('App\Models\ChildCaregory');
    }
}
