<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ApiRegisterRequest extends FormRequest
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
            'email' => 'required|email',
            'password' => 'required|min:6',
            'name' => 'required'
        ];
    }
    public function messages()
    {
        return [
            'name.required' => 'Vui long nhap ten minh vao',
            'email.required' => 'Vui long nhap email minh vao',
            'password.required' => 'Vui long nhap mat khau minh vao',
        ];
    }

    public function attributes()
    {
        return [
            'email' => 'email address',
        ];
    }
}
