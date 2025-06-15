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
  DateTime? waktuMulai;
  DateTime? waktuSelesai;
  DateTime createdAt;
  DateTime updatedAt;
  String jumlahSoal;
  String jawabanBenar;
  String jawabanSalah;

  Data({
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
    required this.jumlahSoal,
    required this.jawabanBenar,
    required this.jawabanSalah,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        jumlahSoal: json["jumlah_soal"]?.toString() ?? "0",
        jawabanBenar: json["jawaban_benar"]?.toString() ?? "0",
        jawabanSalah: json["jawaban_salah"]?.toString() ?? "0",
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
        "jumlah_soal": jumlahSoal,
        "jawaban_benar": jawabanBenar,
        "jawaban_salah": jawabanSalah,
      };

  // Method untuk menghitung skor berdasarkan jawaban benar dan jumlah soal
  String get calculatedSkor {
    try {
      int benar = int.tryParse(jawabanBenar) ?? 0;
      int total = int.tryParse(jumlahSoal) ?? 0;
      if (total > 0) {
        return "$benar/$total";
      }
      return "0/0";
    } catch (e) {
      return "0/0";
    }
  }

  // Method untuk mendapatkan jawaban benar sebagai integer
  int get jawabanBenarInt {
    return int.tryParse(jawabanBenar) ?? 0;
  }

  // Method untuk mendapatkan jawaban salah sebagai integer
  int get jawabanSalahInt {
    return int.tryParse(jawabanSalah) ?? 0;
  }

  // Method untuk mendapatkan jumlah soal sebagai integer
  int get jumlahSoalInt {
    return int.tryParse(jumlahSoal) ?? 0;
  }
}
