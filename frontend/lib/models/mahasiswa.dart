class Mahasiswa {
  final int id;
  final String nama;
  final String nim;
  final String tglLahir;
  final String? jenisKelamin;
  final String alamat;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.tglLahir,
    required this.jenisKelamin,
    required this.alamat,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id'],
      nama: json['nama'],
      nim: json['nim'],
      tglLahir: json['tgl_lahir'],
      jenisKelamin: json['jenis_kelamin'],
      alamat: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'nama': nama,
      'nim': nim,
      'tgl_lahir': tglLahir,
      'jenis_kelamin': jenisKelamin,
      'alamat': alamat,
    };
  }
}
