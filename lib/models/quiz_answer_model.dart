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

  Data({
    required this.quizId,
    required this.correct,
    required this.fase,
    required this.newLevel,
    required this.skorSementara,
    required this.selesai,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quizId: json["quiz_id"],
        correct: json["correct"],
        fase: json["fase"],
        newLevel: json["new_level"],
        skorSementara: json["skor_sementara"],
        selesai: json["selesai"],
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "correct": correct,
        "fase": fase,
        "new_level": newLevel,
        "skor_sementara": skorSementara,
        "selesai": selesai,
      };
}
