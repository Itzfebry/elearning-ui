import 'dart:convert';

class MataPelajaran {
  String id;
  String name;
  String semester;
  String? teacher;
  int materiCount;
  int videoCount;
  DateTime lastUpdated;

  MataPelajaran({
    required this.id,
    required this.name,
    required this.semester,
    this.teacher,
    required this.materiCount,
    required this.videoCount,
    required this.lastUpdated,
  });

  // Factory untuk membuat instance dari JSON
  factory MataPelajaran.fromJson(Map<String, dynamic> json) {
    return MataPelajaran(
      id: json['_id'],
      name: json['name'],
      semester: json['semester'],
      teacher: json['teacher'],
      materiCount: json['materiCount'] ?? 0,
      videoCount: json['videoCount'] ?? 0,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  // Konversi ke JSON (untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "semester": semester,
      "teacher": teacher,
      "materiCount": materiCount,
      "videoCount": videoCount,
      "lastUpdated": lastUpdated.toIso8601String(),
    };
  }

  // Konversi dari List JSON ke List Model
  static List<MataPelajaran> fromJsonList(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((item) => MataPelajaran.fromJson(item)).toList();
  }

  // Konversi dari List Model ke List JSON
  static String toJsonList(List<MataPelajaran> data) {
    final List<Map<String, dynamic>> jsonData =
        data.map((item) => item.toJson()).toList();
    return json.encode(jsonData);
  }
}
