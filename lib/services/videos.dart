import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/models/videos.dart';

class VideoService {
  final String baseUrl = 'http://10.0.2.2:5000/videos'; // Sesuaikan dengan backend

  /// 🔹 **GET** - Ambil semua video
  Future<List<Video>> getAllVideos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return Video.fromJsonList(response.body);
    } else {
      throw Exception('Gagal mengambil data video');
    }
  }

  /// 🔹 **GET** - Ambil video berdasarkan Mata Pelajaran
  Future<List<Video>> getVideosByMataPelajaran(String mataPelajaranId) async {
    final response = await http.get(Uri.parse('$baseUrl?matapelajaran_id=$mataPelajaranId'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => Video.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data video untuk mata pelajaran ini');
    }
  }

  /// 🔹 **POST** - Tambah video baru
  Future<void> addVideo(Video video) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(video.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan video');
    }
  }

  /// 🔹 **PUT** - Update video berdasarkan ID
  Future<void> updateVideo(String id, Video video) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(video.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui video');
    }
  }

  /// 🔹 **DELETE** - Hapus video berdasarkan ID
  Future<void> deleteVideo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus video');
    }
  }
}
