import 'dart:convert';

QuizAttemptModel quizAttemptModelFromJson(String str) =>
    QuizAttemptModel.fromJson(json.decode(str));

String quizAttemptModelToJson(QuizAttemptModel data) =>
    json.encode(data.toJson());

class QuizAttemptModel {
  bool status;
  String message;
  Data data;

  QuizAttemptModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) =>
      QuizAttemptModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
