import 'dart:convert';

class Materi {
  final String id;
  final String title;
  final String? description;
  final String fileUrl;
  final String matapelajaranId;
  final String matapelajaranName; // Tambahan agar bisa menampilkan nama mapel
  final DateTime createdAt;

  Materi({
    required this.id,
    required this.title,
    this.description,
    required this.fileUrl,
    required this.matapelajaranId,
    required this.matapelajaranName, // Tambahan
    required this.createdAt,
  });

  // 🔹 Convert JSON ke Model Materi
  factory Materi.fromJson(Map<String, dynamic> json) {
    return Materi(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      fileUrl: json['fileUrl'],
      matapelajaranId: json['matapelajaranId']['_id'], // Ambil ID dari object
      matapelajaranName: json['matapelajaranId']['name'], // Ambil nama mapel
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // 🔹 Convert Model Materi ke JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'matapelajaranId': {'_id': matapelajaranId, 'name': matapelajaranName}, // Sesuaikan dengan API
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 🔹 Convert dari List JSON ke List Model
  static List<Materi> fromJsonList(String str) {
    final jsonData = json.decode(str);
    return List<Materi>.from(jsonData.map((x) => Materi.fromJson(x)));
  }

  // 🔹 Convert List Model ke JSON String
  static String toJsonList(List<Materi> data) {
    final jsonData = data.map((x) => x.toJson()).toList();
    return json.encode(jsonData);
  }
}
