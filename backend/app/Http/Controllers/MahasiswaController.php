<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use Illuminate\Http\Request;

class MahasiswaController extends Controller
{
    public function index() {
        return Mahasiswa::all();
    }

    public function show($id) {
        return Mahasiswa::findOrFail($id);
    }

    public function update(Request $request,$id) {
        $mhs = Mahasiswa::findOrFail($id);
        $mhs->update($request->all());
        return $mhs;
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'nama' => 'required|string',
            'nim' => 'required|string|unique:mahasiswa,nim',
            'tgl_lahir' => 'required|date',
            'jenis_kelamin' => 'required|in:L,P',
            'alamat' => 'required|string',
        ]);

        $mahasiswa = Mahasiswa::create($validated);
        return response()->json($mahasiswa, 201);
    }

    public function destroy($id) {
        $mhs = Mahasiswa::findOrFail($id);
        $mhs->delete();
        return response()->json(['message' => 'Dihapus']);
    }
}
