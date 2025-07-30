import 'package:flutter/material.dart';
import 'package:jmp_kristiandimas/screens/mahasiswa_form_screen.dart';
import '../models/mahasiswa.dart';
import '../services/mahasiswa_service.dart';
import 'mahasiswa_detail_screen.dart';

class MahasiswaListScreen extends StatefulWidget {
  const MahasiswaListScreen({super.key});

  @override
  State<MahasiswaListScreen> createState() => _MahasiswaListScreenState();
}

class _MahasiswaListScreenState extends State<MahasiswaListScreen> {
  late Future<List<Mahasiswa>> _futureMahasiswa;

  @override
  void initState() {
    super.initState();
    _futureMahasiswa = MahasiswaService.fetchMahasiswa();
  }

  void _showMahasiswaOptions(BuildContext context, Mahasiswa mhs) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SimpleDialog(
          title: Text('Pilih Aksi'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MahasiswaDetailScreen(
                      mahasiswa: mhs,
                    ),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.visibility, color: Colors.blue,),
                  SizedBox(width: 8),
                  Text('Lihat Detail'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(ctx);
                final updated = await Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_) => MahasiswaFormScreen(mahasiswa: mhs),
                  )
                );

                if (updated == true) {
                  setState(() {
                    _futureMahasiswa = MahasiswaService.fetchMahasiswa();
                  });
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.edit, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Update Data'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(ctx);

                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: Text('Yakin ingin menghapus data ${mhs.nama}?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  final success = await MahasiswaService.deleteMahasiswa(mhs.id);
                  if (success) {
                    setState(() {
                      _futureMahasiswa = MahasiswaService.fetchMahasiswa();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Berhasil menghapus ${mhs.nama}')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Gagal menghapus data')),
                    );
                  }
                }
              },
              child: Row(
                children: const [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Hapus Data'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Mahasiswa')),
      body: FutureBuilder<List<Mahasiswa>>(
        future: _futureMahasiswa,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data mahasiswa.'));
          }

          final data = snapshot.data!;
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final mhs = data[index];
              return ListTile(
                title: Text(mhs.nama),
                subtitle: Text('NIM: ${mhs.nim}'),
                onTap: () => _showMahasiswaOptions(context, mhs),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MahasiswaFormScreen()),
          );

          // Jika berhasil tambah, refresh data
          if (result == true) {
            setState(() {
              _futureMahasiswa = MahasiswaService.fetchMahasiswa();
            });
          }
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
