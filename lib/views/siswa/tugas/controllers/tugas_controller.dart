import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/models/tugas_model.dart';
import 'package:http/http.dart' as http;
import 'package:ui/widgets/my_snackbar.dart';

class TugasController extends GetxController {
  TugasModel? tugasM;
  var isLoading = false.obs;

  Future<void> getTugas({required id, required type}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      isLoading(true);

      final url = "${ApiConstants.tugasEnpoint}?id_matpel=$id&type_tugas=$type";
      log("Requesting tugas URL: $url");
      log("Parameters - id_matpel: $id, type_tugas: $type");

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log("Response status: ${response.statusCode}");
      log("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log("Parsed JSON: $json");

        // Cek apakah response adalah object atau array
        if (json is Map<String, dynamic>) {
          // Format response dengan status dan message
          log("Response is Map<String, dynamic>");
          log("Keys in response: ${json.keys.toList()}");

          if (json['status'] == true) {
            try {
              // Log struktur data sebelum parsing
              if (json['data'] != null) {
                log("Data field type: ${json['data'].runtimeType}");
                if (json['data'] is List) {
                  log("Data list length: ${json['data'].length}");
                  if (json['data'].isNotEmpty) {
                    log("First data item type: ${json['data'][0].runtimeType}");
                    log("First data item: ${json['data'][0]}");

                    // Log detail submit_tugas
                    var firstItem = json['data'][0];
                    if (firstItem['submit_tugas'] != null) {
                      log("submit_tugas type: ${firstItem['submit_tugas'].runtimeType}");
                      log("submit_tugas value: ${firstItem['submit_tugas']}");
                      if (firstItem['submit_tugas'] is List) {
                        log("submit_tugas list length: ${firstItem['submit_tugas'].length}");
                        if (firstItem['submit_tugas'].isNotEmpty) {
                          log("First submit_tugas item: ${firstItem['submit_tugas'][0]}");
                        }
                      }
                    }
                  }
                }
              }

              tugasM = TugasModel.fromJson(json);
              log("Tugas model created successfully");
              log("Data length: ${tugasM?.data.length ?? 0}");

              // Log deskripsi untuk setiap tugas
              if (tugasM?.data.isNotEmpty == true) {
                for (int i = 0; i < tugasM!.data.length; i++) {
                  var tugas = tugasM!.data[i];
                  log("Tugas ${i + 1} - ID: ${tugas.id}, Nama: ${tugas.nama}");
                  log("Tugas ${i + 1} - Deskripsi: ${tugas.deskripsi ?? 'null'}");
                }
              }
            } catch (parseError) {
              log("Error parsing TugasModel: $parseError");
              log("JSON structure: $json");
              snackbarfailed("Gagal memparse data tugas: $parseError");
            }
          } else {
            log("API returned false status: ${json['message']}");
            snackbarfailed("Gagal memuat data tugas: ${json['message']}");
          }
        } else if (json is List) {
          // Format response langsung array
          log("Response is List");
          log("List length: ${json.length}");
          if (json.isNotEmpty) {
            log("First item type: ${json[0].runtimeType}");
            log("First item: ${json[0]}");
          }

          try {
            // Validasi bahwa setiap item dalam array adalah Map
            for (int i = 0; i < json.length; i++) {
              if (json[i] is! Map<String, dynamic>) {
                log("Item at index $i is not a Map: ${json[i].runtimeType}");
                throw Exception("Invalid data format at index $i");
              }
            }

            final wrappedJson = {
              "status": true,
              "message": "Success",
              "data": json
            };
            tugasM = TugasModel.fromJson(wrappedJson);
            log("Tugas model created from array response");
            log("Data length: ${tugasM?.data.length ?? 0}");
          } catch (parseError) {
            log("Error parsing array response: $parseError");
            log("Array structure: $json");
            snackbarfailed("Gagal memparse data tugas: $parseError");
          }
        } else {
          log("Unexpected response format: ${json.runtimeType}");
          snackbarfailed("Format response tidak dikenali");
        }
      } else {
        log("Terjadi kesalahan get data: ${response.statusCode}");
        log("Error response: ${response.body}");
        snackbarfailed(
            "Gagal memuat data tugas. Status: ${response.statusCode}");
      }
    } catch (e) {
      log("Error get tugas: $e");
      log("Error stack trace: ${StackTrace.current}");
      snackbarfailed("Terjadi kesalahan: $e");
    } finally {
      isLoading(false);
    }
  }
}
