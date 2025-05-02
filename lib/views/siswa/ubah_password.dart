import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/ubah_password_controller.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final ubahPasswordC = Get.find<UbahPasswordController>();

  bool _isObscureOld = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Simulasi proses ubah password
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password berhasil diubah')),
      );

      // Kosongkan field
      ubahPasswordC.oldPasswordC.value.clear();
      ubahPasswordC.newPasswordC.value.clear();
      ubahPasswordC.confirmPasswordC.value.clear();
    }
  }

  @override
  void dispose() {
    ubahPasswordC.oldPasswordC.value.dispose();
    ubahPasswordC.newPasswordC.value.dispose();
    ubahPasswordC.confirmPasswordC.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: ubahPasswordC.oldPasswordC.value,
                obscureText: _isObscureOld,
                decoration: InputDecoration(
                  labelText: 'Password Lama',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureOld ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureOld = !_isObscureOld;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password lama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ubahPasswordC.newPasswordC.value,
                obscureText: _isObscureNew,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureNew ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureNew = !_isObscureNew;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password baru minimal 6 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ubahPasswordC.confirmPasswordC.value,
                obscureText: _isObscureConfirm,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureConfirm
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureConfirm = !_isObscureConfirm;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value != ubahPasswordC.newPasswordC.value.text) {
                    return 'Konfirmasi password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Obx(() => ElevatedButton(
                    onPressed: ubahPasswordC.isLoading.value
                        ? null
                        : () {
                            ubahPasswordC.ubahPassword();
                          },
                    child: Text(ubahPasswordC.isLoading.value
                        ? 'Loading...'
                        : 'Simpan'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
