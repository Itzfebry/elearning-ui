import 'dart:convert';

TahunAjaranModel tahunAjaranModelFromJson(String str) =>
    TahunAjaranModel.fromJson(json.decode(str));

String tahunAjaranModelToJson(TahunAjaranModel data) =>
    json.encode(data.toJson());

class TahunAjaranModel {
  bool status;
  String message;
  List<Datum> data;

  TahunAjaranModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TahunAjaranModel.fromJson(Map<String, dynamic> json) =>
      TahunAjaranModel(
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
  String tahun;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.tahun,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        tahun: json["tahun"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "tahun": tahun,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
