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
  int? waktu;
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
    this.waktu,
    required this.matapelajaranId,
    required this.createdAt,
    required this.updatedAt,
    required this.quizAttempt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()) ?? 0,
        judul: json["judul"]?.toString() ?? "",
        deskripsi: json["deskripsi"]?.toString() ?? "",
        totalSoal: json["total_soal"] is int
            ? json["total_soal"]
            : int.tryParse(json["total_soal"].toString()) ?? 0,
        totalSoalTampil: json["total_soal_tampil"]?.toString() ?? "0",
        waktu: json["waktu"] is int
            ? (json["waktu"] > 0 && json["waktu"] <= 1440
                ? json["waktu"]
                : null)
            : (json["waktu"] == null
                ? null
                : (() {
                    int? parsed = int.tryParse(json["waktu"].toString());
                    return (parsed != null && parsed > 0 && parsed <= 1440)
                        ? parsed
                        : null;
                  })()),
        matapelajaranId: json["matapelajaran_id"] is int
            ? json["matapelajaran_id"]
            : int.tryParse(json["matapelajaran_id"].toString()) ?? 0,
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"].toString()) ?? DateTime.now()
            : DateTime.now(),
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
        "waktu": waktu,
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
  DateTime? waktuMulai;
  DateTime? waktuSelesai;
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
    this.waktuMulai,
    this.waktuSelesai,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => QuizAttempt(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()) ?? 0,
        quizId: json["quiz_id"] is int
            ? json["quiz_id"]
            : int.tryParse(json["quiz_id"].toString()) ?? 0,
        nisn: json["nisn"]?.toString() ?? "",
        skor: json["skor"]?.toString() ?? "0",
        levelAkhir: json["level_akhir"] is int
            ? json["level_akhir"]
            : int.tryParse(json["level_akhir"].toString()) ?? 1,
        jumlahSoalDijawab: json["jumlah_soal_dijawab"] is int
            ? json["jumlah_soal_dijawab"]
            : int.tryParse(json["jumlah_soal_dijawab"].toString()) ?? 0,
        fase: json["fase"] is int
            ? json["fase"]
            : int.tryParse(json["fase"].toString()) ?? 1,
        benar: json["benar"]?.toString() ?? "{}",
        waktuMulai: json["waktu_mulai"] != null
            ? DateTime.tryParse(json["waktu_mulai"].toString())
            : null,
        waktuSelesai: json["waktu_selesai"] != null
            ? DateTime.tryParse(json["waktu_selesai"].toString())
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"].toString()) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"].toString()) ?? DateTime.now()
            : DateTime.now(),
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
        "waktu_mulai": waktuMulai?.toIso8601String(),
        "waktu_selesai": waktuSelesai?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
