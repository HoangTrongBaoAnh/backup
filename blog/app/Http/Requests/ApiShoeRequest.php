<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ApiShoeRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'title' => 'required|min:3|max:10|unique:pgsql.shoes|string',
            'child_category' => 'required|integer',
            'category_id' => 'required|integer',
            'picture' => 'image|mimes:jpeg,png|max:2000',
            'price' => 'required|min:10000|integer'
        ];
    }

    public function messages()
    {
        return [
            'title.required' => 'A title is required',
            'child_category.integer' => 'A child category is required',
            'category_id.integer' => 'A category is required'
        ];
    }
    
    // public function handle($request, Closure $next)
    // {
    //        return $next($request)
    //            ->header('Access-Control-Allow-Origin', '*')
    //            ->header('Access-Control-Allow-Methods', '*')
    //            ->header('Access-Control-Allow-Credentials', 'true')
    //            ->header('Access-Control-Allow-Headers', 'X-CSRF-Token');
    // }
}
