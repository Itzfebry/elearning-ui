import 'dart:convert';

MateriBukuModel materiBukuModelFromJson(String str) =>
    MateriBukuModel.fromJson(json.decode(str));

String materiBukuModelToJson(MateriBukuModel data) =>
    json.encode(data.toJson());

class MateriBukuModel {
  bool status;
  String message;
  List<Datum> data;

  MateriBukuModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MateriBukuModel.fromJson(Map<String, dynamic> json) =>
      MateriBukuModel(
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
  int matapelajaranId;
  String semester;
  String type;
  String judulMateri;
  String deskripsi;
  String path;
  String tahunAjaran;
  DateTime createdAt;
  DateTime updatedAt;
  MataPelajaran mataPelajaran;

  Datum({
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
    required this.mataPelajaran,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        mataPelajaran: MataPelajaran.fromJson(json["mata_pelajaran"]),
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
        "mata_pelajaran": mataPelajaran.toJson(),
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
