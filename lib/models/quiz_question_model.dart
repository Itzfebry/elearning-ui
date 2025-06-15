import 'dart:convert';

QuizQuestionModel quizQuestionModelFromJson(String str) =>
    QuizQuestionModel.fromJson(json.decode(str));

String quizQuestionModelToJson(QuizQuestionModel data) =>
    json.encode(data.toJson());

class QuizQuestionModel {
  bool status;
  String message;
  Data? data;

  QuizQuestionModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      QuizQuestionModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  int quizId;
  String pertanyaan;
  String opsiA;
  String opsiB;
  String opsiC;
  String opsiD;
  String jawabanBenar;
  int level;
  int? waktuTersisa;
  DateTime? waktuMulai;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.quizId,
    required this.pertanyaan,
    required this.opsiA,
    required this.opsiB,
    required this.opsiC,
    required this.opsiD,
    required this.jawabanBenar,
    required this.level,
    this.waktuTersisa,
    this.waktuMulai,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()) ?? 0,
        quizId: json["quiz_id"] is int
            ? json["quiz_id"]
            : int.tryParse(json["quiz_id"].toString()) ?? 0,
        pertanyaan: json["pertanyaan"]?.toString() ?? "",
        opsiA: json["opsi_a"]?.toString() ?? "",
        opsiB: json["opsi_b"]?.toString() ?? "",
        opsiC: json["opsi_c"]?.toString() ?? "",
        opsiD: json["opsi_d"]?.toString() ?? "",
        jawabanBenar: json["jawaban_benar"]?.toString() ?? "",
        level: json["level"] is int
            ? json["level"]
            : int.tryParse(json["level"].toString()) ?? 0,
        waktuTersisa: json["waktu_tersisa"] == null
            ? null
            : int.tryParse(json["waktu_tersisa"].toString()),
        waktuMulai: json["waktu_mulai"] != null
            ? DateTime.tryParse(json["waktu_mulai"].toString())
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
        "pertanyaan": pertanyaan,
        "opsi_a": opsiA,
        "opsi_b": opsiB,
        "opsi_c": opsiC,
        "opsi_d": opsiD,
        "jawaban_benar": jawabanBenar,
        "level": level,
        "waktu_tersisa": waktuTersisa,
        "waktu_mulai": waktuMulai?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
