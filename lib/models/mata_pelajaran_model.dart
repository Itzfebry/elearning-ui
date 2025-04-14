// To parse this JSON data, do
//
//     final mataPelajaranModel = mataPelajaranModelFromJson(jsonString);

import 'dart:convert';

MataPelajaranModel mataPelajaranModelFromJson(String str) =>
    MataPelajaranModel.fromJson(json.decode(str));

String mataPelajaranModelToJson(MataPelajaranModel data) =>
    json.encode(data.toJson());

class MataPelajaranModel {
  bool status;
  String message;
  List<Datum> data;

  MataPelajaranModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MataPelajaranModel.fromJson(Map<String, dynamic> json) =>
      MataPelajaranModel(
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
  String nama;
  String guruNip;
  String kelas;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;
  Guru guru;
  List<Materi> materi;
  int jumlahBuku;
  int jumlahVideo;

  Datum({
    required this.id,
    required this.nama,
    required this.guruNip,
    required this.kelas,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
    required this.guru,
    required this.materi,
    required this.jumlahBuku,
    required this.jumlahVideo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nama: json["nama"],
        guruNip: json["guru_nip"],
        kelas: json["kelas"],
        tahunAjaran: json["tahun_ajaran"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        guru: Guru.fromJson(json["guru"]),
        materi:
            List<Materi>.from(json["materi"].map((x) => Materi.fromJson(x))),
        jumlahBuku: json["jumlah_buku"],
        jumlahVideo: json["jumlah_video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "guru_nip": guruNip,
        "kelas": kelas,
        "tahun_ajaran": tahunAjaran,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "guru": guru.toJson(),
        "materi": List<dynamic>.from(materi.map((x) => x.toJson())),
        "jumlah_buku": jumlahBuku,
        "jumlah_video": jumlahVideo,
      };
}

class Guru {
  int id;
  int userId;
  String nip;
  String nama;
  String jk;
  DateTime createdAt;
  DateTime updatedAt;

  Guru({
    required this.id,
    required this.userId,
    required this.nip,
    required this.nama,
    required this.jk,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Guru.fromJson(Map<String, dynamic> json) => Guru(
        id: json["id"],
        userId: json["user_id"],
        nip: json["nip"],
        nama: json["nama"],
        jk: json["jk"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nip": nip,
        "nama": nama,
        "jk": jk,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Materi {
  int id;
  DateTime tanggal;
  int matapelajaranId;
  String semester;
  String type;
  String judulMateri;
  String deskripsi;
  String path;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;

  Materi({
    required this.id,
    required this.tanggal,
    required this.matapelajaranId,
    required this.semester,
    required this.type,
    required this.judulMateri,
    required this.deskripsi,
    required this.path,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Materi.fromJson(Map<String, dynamic> json) => Materi(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        matapelajaranId: json["matapelajaran_id"],
        semester: json["semester"],
        type: json["type"],
        judulMateri: json["judul_materi"],
        deskripsi: json["deskripsi"],
        path: json["path"],
        tahunAjaran: json["tahun_ajaran"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "matapelajaran_id": matapelajaranId,
        "semester": semester,
        "type": type,
        "judul_materi": judulMateri,
        "deskripsi": deskripsi,
        "path": path,
        "tahun_ajaran": tahunAjaran,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
