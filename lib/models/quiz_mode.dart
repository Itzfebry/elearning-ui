// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  bool status;
  String message;
  List<Datum> data;

  QuizModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
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
  QuizAttempt? quizAttempt;

  Datum({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.totalSoal,
    required this.totalSoalTampil,
    required this.matapelajaranId,
    required this.createdAt,
    required this.updatedAt,
    required this.quizAttempt,
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
        quizAttempt: json["quiz_attempt"] == null
            ? null
            : QuizAttempt.fromJson(json["quiz_attempt"]),
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
        "quiz_attempt": quizAttempt?.toJson(),
      };
}

class QuizAttempt {
  int id;
  int quizId;
  String nisn;
  String skor;
  int levelAkhir;
  int jumlahSoalDijawab;
  int fase;
  String benar;
  DateTime createdAt;
  DateTime updatedAt;

  QuizAttempt({
    required this.id,
    required this.quizId,
    required this.nisn,
    required this.skor,
    required this.levelAkhir,
    required this.jumlahSoalDijawab,
    required this.fase,
    required this.benar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => QuizAttempt(
        id: json["id"],
        quizId: json["quiz_id"],
        nisn: json["nisn"],
        skor: json["skor"],
        levelAkhir: json["level_akhir"],
        jumlahSoalDijawab: json["jumlah_soal_dijawab"],
        fase: json["fase"],
        benar: json["benar"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quiz_id": quizId,
        "nisn": nisn,
        "skor": skor,
        "level_akhir": levelAkhir,
        "jumlah_soal_dijawab": jumlahSoalDijawab,
        "fase": fase,
        "benar": benar,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
