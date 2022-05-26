<?php

use Illuminate\Database\Seeder;
use App\Models\Category;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $category = new Category();
        $category->content = "aaaa";
        $category->save();
    }
}
