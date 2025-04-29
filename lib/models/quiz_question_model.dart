import 'dart:convert';

QuizQuestionModel quizQuestionModelFromJson(String str) =>
    QuizQuestionModel.fromJson(json.decode(str));

String quizQuestionModelToJson(QuizQuestionModel data) =>
    json.encode(data.toJson());

class QuizQuestionModel {
  bool status;
  String message;
  Data data;

  QuizQuestionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      QuizQuestionModel(
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
  String pertanyaan;
  String opsiA;
  String opsiB;
  String opsiC;
  String opsiD;
  String jawabanBenar;
  int level;
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        quizId: json["quiz_id"],
        pertanyaan: json["pertanyaan"],
        opsiA: json["opsi_a"],
        opsiB: json["opsi_b"],
        opsiC: json["opsi_c"],
        opsiD: json["opsi_d"],
        jawabanBenar: json["jawaban_benar"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
