// To parse this JSON data, do
//
//     final tugasModel = tugasModelFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

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

  factory TugasModel.fromJson(Map<String, dynamic> json) {
    try {
      return TugasModel(
        status: json["status"] ?? false,
        message: json["message"] ?? "No message",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : <Datum>[],
      );
    } catch (e) {
      throw Exception("Error parsing TugasModel: $e");
    }
  }

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

  factory Datum.fromJson(Map<String, dynamic> json) {
    try {
      log("Parsing Datum with id: ${json['id']}");
      log("submit_tugas type: ${json['submit_tugas']?.runtimeType}");
      log("submit_tugas value: ${json['submit_tugas']}");

      SubmitTugas? submitTugas;
      if (json["submit_tugas"] == null) {
        submitTugas = null;
        log("submit_tugas is null");
      } else if (json["submit_tugas"] is List) {
        var submitList = json["submit_tugas"] as List;
        log("submit_tugas is List with length: ${submitList.length}");
        if (submitList.isNotEmpty) {
          submitTugas = SubmitTugas.fromJson(submitList[0]);
          log("Created SubmitTugas from first item in list");
        } else {
          submitTugas = null;
          log("submit_tugas list is empty");
        }
      } else if (json["submit_tugas"] is Map<String, dynamic>) {
        submitTugas = SubmitTugas.fromJson(json["submit_tugas"]);
        log("Created SubmitTugas from Map");
      } else {
        submitTugas = null;
        log("submit_tugas is neither List nor Map, type: ${json['submit_tugas'].runtimeType}");
      }

      return Datum(
        id: json["id"] ?? 0,
        tanggal: json["tanggal"] != null
            ? DateTime.parse(json["tanggal"].toString())
            : DateTime.now(),
        tenggat: json["tenggat"] != null
            ? DateTime.parse(json["tenggat"].toString())
            : DateTime.now(),
        guruNip: json["guru_nip"] ?? "",
        nama: json["nama"] ?? "",
        matapelajaranId: json["matapelajaran_id"] ?? 0,
        kelas: json["kelas"] ?? "",
        tahunAjaran: json["tahun_ajaran"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
        mataPelajaran: json["mata_pelajaran"] != null
            ? MataPelajaran.fromJson(json["mata_pelajaran"])
            : MataPelajaran(
                id: 0,
                nama: "",
                guruNip: "",
                kelas: "",
                tahunAjaran: "",
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
        submitTugas: submitTugas,
      );
    } catch (e) {
      log("Error parsing Datum: $e");
      throw Exception("Error parsing Datum: $e");
    }
  }

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

  factory MataPelajaran.fromJson(Map<String, dynamic> json) {
    try {
      return MataPelajaran(
        id: json["id"] ?? 0,
        nama: json["nama"] ?? "",
        guruNip: json["guru_nip"] ?? "",
        kelas: json["kelas"] ?? "",
        tahunAjaran: json["tahun_ajaran"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
      );
    } catch (e) {
      throw Exception("Error parsing MataPelajaran: $e");
    }
  }

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

  factory SubmitTugas.fromJson(Map<String, dynamic> json) {
    try {
      return SubmitTugas(
        id: json["id"] ?? 0,
        tanggal: json["tanggal"] != null
            ? DateTime.parse(json["tanggal"].toString())
            : DateTime.now(),
        nisn: json["nisn"] ?? "",
        tugasId: json["tugas_id"] ?? 0,
        text: json["text"],
        file: json["file"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : DateTime.now(),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : DateTime.now(),
      );
    } catch (e) {
      throw Exception("Error parsing SubmitTugas: $e");
    }
  }

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
