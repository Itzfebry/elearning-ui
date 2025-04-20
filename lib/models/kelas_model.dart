import 'dart:convert';

KelasModel kelasModelFromJson(String str) =>
    KelasModel.fromJson(json.decode(str));

String kelasModelToJson(KelasModel data) => json.encode(data.toJson());

class KelasModel {
  bool status;
  String message;
  List<Datum> data;

  KelasModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
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
  String nama;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.nama,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nama: json["nama"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
