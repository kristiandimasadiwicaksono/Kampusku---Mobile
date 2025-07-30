import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa.dart';

class MahasiswaService {
  static const String _baseUrl = 'http://localhost:8000/api/mahasiswa'; // ganti sesuai API kamu

  static Future<List<Mahasiswa>> fetchMahasiswa() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Mahasiswa.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data mahasiswa');
    }
  }
  
  static Future<bool> postMahasiswa(Mahasiswa mhs) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mhs.toJson()),
    );

    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE BODY: ${utf8.decode(response.bodyBytes)}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  static Future<bool> updateMahasiswa(Mahasiswa mhs) async {
    final url = '$_baseUrl/${mhs.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mhs.toJson()),
    );
    
    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE BODY: ${utf8.decode(response.bodyBytes)}');

    return response.statusCode == 200;
  }

  static Future<bool> deleteMahasiswa(int id) async {
    final url = '$_baseUrl/$id';
    final response = await http.delete(Uri.parse(url));

    print('DELETE STATUS CODE: ${response.statusCode}');
    print('DELETE RESPONSE: ${utf8.decode(response.bodyBytes)}');

    return response.statusCode == 200;
  }
}
