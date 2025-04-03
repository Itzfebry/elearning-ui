import 'dart:convert'; 

class Video {
  final String id;
  final String title;
  final String? description;
  final String videoUrl;
  final String matapelajaranId;
  final String matapelajaranName; // Tambahkan ini
  final DateTime createdAt;

  Video({
    required this.id,
    required this.title,
    this.description,
    required this.videoUrl,
    required this.matapelajaranId,
    required this.matapelajaranName, // Tambahkan ini
    required this.createdAt,
  });

  // 🔹 Convert dari JSON ke Model
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      matapelajaranId: json['matapelajaranId']['_id'], // Ambil ID dari object
      matapelajaranName: json['matapelajaranId']['name'], // Ambil nama mapel
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // 🔹 Convert dari Model ke JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'matapelajaranId': {'_id': matapelajaranId, 'name': matapelajaranName}, // Sesuaikan dengan API
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 🔹 Convert List JSON ke List Model
  static List<Video> fromJsonList(String jsonString) {
    final List<dynamic> data = json.decode(jsonString);
    return data.map((item) => Video.fromJson(item)).toList();
  }
}
