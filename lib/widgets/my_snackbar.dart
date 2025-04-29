import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/widgets/my_text.dart';

snackbarfailed(var msg) {
  return Get.snackbar(
    "Gagal!",
    "message",
    backgroundColor: Colors.grey.shade400,
    duration: const Duration(seconds: 3),
    colorText: Colors.red.shade500,
    messageText: Text(
      msg,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}

snackbarSuccess(var msg) {
  return Get.snackbar(
    "Berhasil",
    "message",
    backgroundColor: Colors.grey.shade400,
    duration: const Duration(seconds: 3),
    colorText: Colors.green.shade500,
    messageText: Text(
      msg,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );
}

snackbarAlert(var title, var msg, Color color) {
  return Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: msg,
      backgroundColor: color,
      duration: const Duration(seconds: 8),
    ),
  );
}
