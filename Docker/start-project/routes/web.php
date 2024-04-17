<?php

use Illuminate\Support\Facades\Route;
use \Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/simples', function () {
    return "<h1>Rota Simples</h1>";
});

Route::resource('/eixo', 'App\Http\Controllers\EixoController');
Route::resource('/nivel', 'App\Http\Controllers\NivelController');
Route::resource('/resource', 'App\Http\Controllers\ResourceController');
Route::resource('/role', 'App\Http\Controllers\RoleController');
Route::resource('/curso', 'App\Http\Controllers\CursoController');
Route::resource('/permission', 'App\Http\Controllers\PermissionController');
Route::resource('/categoria', 'App\Http\Controllers\CategoriaController');
Route::resource('/turma', 'App\Http\Controllers\TurmaController');
Route::resource('/user', 'App\Http\Controllers\UserController');
Route::resource('/aluno', 'App\Http\Controllers\AlunoController');
Route::resource('/documento', 'App\Http\Controllers\DocumentoController');
Route::resource('/comprovante', 'App\Http\Controllers\ComprovanteController');
Route::resource('/declaracao', 'App\Http\Controllers\DeclaracaoController');