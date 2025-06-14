import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/constans/api_constans.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/widgets/my_snackbar.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  SharedPreferences? prefs;
  TextEditingController loginC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<void> login() async {
    prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      isLoading(true);
      Map body = {
        'login': loginC.text,
        'password': passwordC.text,
      };
      if (loginC.text == "" || passwordC.text == "") {
        snackbarfailed("Inputan login tidak boleh kosong!");
      } else {
        // Tambahkan log URL endpoint untuk debugging
        ApiConstants.debugApiUrls();
        debugPrint("Login endpoint: ${ApiConstants.loginEnpoint}");
        final response = await http.post(
          Uri.parse(ApiConstants.loginEnpoint),
          body: jsonEncode(body),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          // Cek struktur JSON sebelum akses
          if (json['data'] == null || json['data']['user'] == null) {
            debugPrint("Struktur JSON tidak sesuai: ${response.body}");
            snackbarfailed("Login gagal, data user tidak ditemukan!");
            return;
          }
          final user = json['data']['user'];
          await prefs?.setString('token', json['data']['token']);
          await prefs?.setString('nama', user['nama']);
          await prefs?.setString('role', user['user']['role']);

          if (user['user']['role'] == "siswa") {
            await prefs?.setString('nisn', user['nisn']);
            Get.offAllNamed(AppRoutes.siswaDashboard);
          } else {
            await prefs?.setString('nip', user['nip']);
            Get.offAllNamed(AppRoutes.guruDashboard);
          }
          snackbarSuccess("Login Berhasil");
        } else {
          debugPrint("Login gagal: ${response.body}");
          snackbarfailed("Login Gagal, inputan atau sandi salah!");
        }
      }
    } catch (e) {
      debugPrint("Login Exception: $e");
      snackbarfailed("Terjadi error: $e");
    } finally {
      isLoading(false);
    }
  }
}
