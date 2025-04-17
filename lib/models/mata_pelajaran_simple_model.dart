import 'dart:convert';

MataPelajaranSimpleModel mataPelajaranSimpleModelFromJson(String str) =>
    MataPelajaranSimpleModel.fromJson(json.decode(str));

String mataPelajaranSimpleModelToJson(MataPelajaranSimpleModel data) =>
    json.encode(data.toJson());

class MataPelajaranSimpleModel {
  bool status;
  String message;
  List<Datum> data;

  MataPelajaranSimpleModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MataPelajaranSimpleModel.fromJson(Map<String, dynamic> json) =>
      MataPelajaranSimpleModel(
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

  Datum({
    required this.id,
    required this.nama,
    required this.guruNip,
    required this.kelas,
    required this.tahunAjaran,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
