import 'dart:convert';

DetailSubmitTugasSiswaModel detailSubmitTugasSiswaModelFromJson(String str) =>
    DetailSubmitTugasSiswaModel.fromJson(json.decode(str));

String detailSubmitTugasSiswaModelToJson(DetailSubmitTugasSiswaModel data) =>
    json.encode(data.toJson());

class DetailSubmitTugasSiswaModel {
  bool status;
  String message;
  List<Datum> data;

  DetailSubmitTugasSiswaModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DetailSubmitTugasSiswaModel.fromJson(Map<String, dynamic> json) =>
      DetailSubmitTugasSiswaModel(
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
  int userId;
  String nisn;
  String nama;
  String jk;
  String kelas;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;
  SubmitTugas? submitTugas;

  Datum({
    required this.id,
    required this.userId,
    required this.nisn,
    required this.nama,
    required this.jk,
    required this.kelas,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
    required this.submitTugas,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        nisn: json["nisn"],
        nama: json["nama"],
        jk: json["jk"],
        kelas: json["kelas"],
        tahunAjaran: json["tahun_ajaran"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        submitTugas: json["submit_tugas"] == null
            ? null
            : SubmitTugas.fromJson(json["submit_tugas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nisn": nisn,
        "nama": nama,
        "jk": jk,
        "kelas": kelas,
        "tahun_ajaran": tahunAjaran,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "submit_tugas": submitTugas?.toJson(),
      };
}

class SubmitTugas {
  int id;
  DateTime tanggal;
  String nisn;
  int tugasId;
  String? text;
  String? file;
  int? nilai;
  DateTime createdAt;
  DateTime updatedAt;
  Tugas tugas;

  SubmitTugas({
    required this.id,
    required this.tanggal,
    required this.nisn,
    required this.tugasId,
    required this.text,
    required this.file,
    this.nilai,
    required this.createdAt,
    required this.updatedAt,
    required this.tugas,
  });

  factory SubmitTugas.fromJson(Map<String, dynamic> json) => SubmitTugas(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        nisn: json["nisn"],
        tugasId: json["tugas_id"],
        text: json["text"],
        file: json["file"],
        nilai: json["nilai"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tugas: Tugas.fromJson(json["tugas"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "nisn": nisn,
        "tugas_id": tugasId,
        "text": text,
        "file": file,
        "nilai": nilai,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tugas": tugas.toJson(),
      };
}

class Tugas {
  int id;
  DateTime tanggal;
  DateTime tenggat;
  String guruNip;
  String nama;
  int matapelajaranId;
  String kelas;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;

  Tugas({
    required this.id,
    required this.tanggal,
    required this.tenggat,
    required this.guruNip,
    required this.nama,
    required this.matapelajaranId,
    required this.kelas,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tugas.fromJson(Map<String, dynamic> json) => Tugas(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        tenggat: DateTime.parse(json["tenggat"]),
        guruNip: json["guru_nip"],
        nama: json["nama"],
        matapelajaranId: json["matapelajaran_id"],
        kelas: json["kelas"],
        tahunAjaran: json["tahun_ajaran"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "tenggat":
            "${tenggat.year.toString().padLeft(4, '0')}-${tenggat.month.toString().padLeft(2, '0')}-${tenggat.day.toString().padLeft(2, '0')}",
        "guru_nip": guruNip,
        "nama": nama,
        "matapelajaran_id": matapelajaranId,
        "kelas": kelas,
        "tahun_ajaran": tahunAjaran,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
