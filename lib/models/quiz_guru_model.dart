// To parse this JSON data, do
//
//     final quizGuruModel = quizGuruModelFromJson(jsonString);

import 'dart:convert';

QuizGuruModel quizGuruModelFromJson(String str) =>
    QuizGuruModel.fromJson(json.decode(str));

String quizGuruModelToJson(QuizGuruModel data) => json.encode(data.toJson());

class QuizGuruModel {
  bool status;
  String message;
  List<Datum> data;

  QuizGuruModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizGuruModel.fromJson(Map<String, dynamic> json) => QuizGuruModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String judul;
  String deskripsi;
  int totalSoal;
  String totalSoalTampil;
  int matapelajaranId;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.totalSoal,
    required this.totalSoalTampil,
    required this.matapelajaranId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        totalSoal: json["total_soal"],
        totalSoalTampil: json["total_soal_tampil"],
        matapelajaranId: json["matapelajaran_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
        "total_soal": totalSoal,
        "total_soal_tampil": totalSoalTampil,
        "matapelajaran_id": matapelajaranId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
