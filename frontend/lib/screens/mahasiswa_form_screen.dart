import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/mahasiswa_service.dart';

class MahasiswaFormScreen extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  const MahasiswaFormScreen({super.key, this.mahasiswa});

  @override
  State<MahasiswaFormScreen> createState() => _MahasiswaFormScreenState();
}

class _MahasiswaFormScreenState extends State<MahasiswaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _tglLahirController = TextEditingController();
  final _alamatController = TextEditingController();

  String? _jenisKelamin;

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _tglLahirController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    final m = widget.mahasiswa;
    if (m != null) {
      _namaController.text = m.nama;
      _nimController.text = m.nim;
      _tglLahirController.text = m.tglLahir;
      _jenisKelamin = m.jenisKelamin;
      _alamatController.text = m.alamat;
    }
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      final mahasiswa = Mahasiswa(
        id: widget.mahasiswa?.id ?? 0,
        nama: _namaController.text,
        nim: _nimController.text,
        tglLahir: _tglLahirController.text,
        jenisKelamin: _jenisKelamin,
        alamat: _alamatController.text,
    );

    bool success = false;

    if (widget.mahasiswa == null) {
      success = await MahasiswaService.postMahasiswa(mahasiswa);
    } else {
      success = await MahasiswaService.updateMahasiswa(mahasiswa);
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mahasiswa berhasil ditambahkan!')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menambahkan data')),
      );
    }// kembali ke list
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mahasiswa == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'NIM wajib diisi' : null,
              ),
              InkWell(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _tglLahirController.text = pickedDate.toIso8601String().split('T')[0];
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _tglLahirController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Lahir',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Tanggal lahir wajib diisi' : null,
                  ),
                ),
              ),
              DropdownButtonFormField<String>(
                value: _jenisKelamin,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                items: const [
                  DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Pilih jenis kelamin' : null,
              ),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: 'Alamat'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Alamat wajib diisi' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}