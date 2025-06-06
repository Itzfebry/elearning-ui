// To parse this JSON data, do
//
//     final tugasModel = tugasModelFromJson(jsonString);

import 'dart:convert';

TugasModel tugasModelFromJson(String str) =>
    TugasModel.fromJson(json.decode(str));

String tugasModelToJson(TugasModel data) => json.encode(data.toJson());

class TugasModel {
  bool status;
  String message;
  List<Datum> data;

  TugasModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TugasModel.fromJson(Map<String, dynamic> json) => TugasModel(
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
  DateTime tanggal;
  DateTime tenggat;
  String guruNip;
  String nama;
  int matapelajaranId;
  String kelas;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;
  MataPelajaran mataPelajaran;
  SubmitTugas? submitTugas;

  Datum({
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
    required this.mataPelajaran,
    required this.submitTugas,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        mataPelajaran: MataPelajaran.fromJson(json["mata_pelajaran"]),
        submitTugas: json["submit_tugas"] == null
            ? null
            : SubmitTugas.fromJson(json["submit_tugas"]),
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
        "mata_pelajaran": mataPelajaran.toJson(),
        "submit_tugas": submitTugas?.toJson(),
      };
}

class MataPelajaran {
  int id;
  String nama;
  String guruNip;
  String kelas;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;

  MataPelajaran({
    required this.id,
    required this.nama,
    required this.guruNip,
    required this.kelas,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MataPelajaran.fromJson(Map<String, dynamic> json) => MataPelajaran(
        id: json["id"],
        nama: json["nama"],
        guruNip: json["guru_nip"],
        kelas: json["kelas"],
        tahunAjaran: json["tahun_ajaran"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "guru_nip": guruNip,
        "kelas": kelas,
        "tahun_ajaran": tahunAjaran,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class SubmitTugas {
  int id;
  DateTime tanggal;
  String nisn;
  int tugasId;
  String? text;
  String? file;
  DateTime createdAt;
  DateTime updatedAt;

  SubmitTugas({
    required this.id,
    required this.tanggal,
    required this.nisn,
    required this.tugasId,
    required this.text,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubmitTugas.fromJson(Map<String, dynamic> json) => SubmitTugas(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        nisn: json["nisn"],
        tugasId: json["tugas_id"],
        text: json["text"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "nisn": nisn,
        "tugas_id": tugasId,
        "text": text,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
