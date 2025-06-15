import 'dart:convert';

QuizAnswerModel quizAnswerModelFromJson(String str) =>
    QuizAnswerModel.fromJson(json.decode(str));

String quizAnswerModelToJson(QuizAnswerModel data) =>
    json.encode(data.toJson());

class QuizAnswerModel {
  bool status;
  String message;
  Data data;

  QuizAnswerModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuizAnswerModel(
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
  int quizId;
  int correct;
  int fase;
  int newLevel;
  int skorSementara;
  bool selesai;
  int? waktuTersisa;

  Data({
    required this.quizId,
    required this.correct,
    required this.fase,
    required this.newLevel,
    required this.skorSementara,
    required this.selesai,
    this.waktuTersisa,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizId: json["quiz_id"] is int
            ? json["quiz_id"]
            : int.tryParse(json["quiz_id"].toString()) ?? 0,
        correct: json["correct"] is int
            ? json["correct"]
            : int.tryParse(json["correct"].toString()) ?? 0,
        fase: json["fase"] is int
            ? json["fase"]
            : int.tryParse(json["fase"].toString()) ?? 1,
        newLevel: json["new_level"] is int
            ? json["new_level"]
            : int.tryParse(json["new_level"].toString()) ?? 1,
        skorSementara: json["skor_sementara"] is int
            ? json["skor_sementara"]
            : int.tryParse(json["skor_sementara"].toString()) ?? 0,
        selesai: json["selesai"] is bool
            ? json["selesai"]
            : json["selesai"] == 1 ||
                json["selesai"] == "1" ||
                json["selesai"] == true,
        waktuTersisa: json["waktu_tersisa"] is int
            ? json["waktu_tersisa"]
            : int.tryParse(json["waktu_tersisa"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "correct": correct,
        "fase": fase,
        "new_level": newLevel,
        "skor_sementara": skorSementara,
        "selesai": selesai,
        "waktu_tersisa": waktuTersisa,
      };
}
