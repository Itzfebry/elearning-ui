import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/views/siswa/controllers/ubah_password_controller.dart';

class UbahPasswordPage extends StatefulWidget {
  const UbahPasswordPage({super.key});

  @override
  State<UbahPasswordPage> createState() => _UbahPasswordPageState();
}

class _UbahPasswordPageState extends State<UbahPasswordPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final ubahPasswordC = Get.find<UbahPasswordController>();

  bool _isObscureOld = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;

  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    ubahPasswordC.oldPasswordC.value.dispose();
    ubahPasswordC.newPasswordC.value.dispose();
    ubahPasswordC.confirmPasswordC.value.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ubahPasswordC.oldPasswordC.value.clear();
      ubahPasswordC.newPasswordC.value.clear();
      ubahPasswordC.confirmPasswordC.value.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Ubah Password',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF667EEA),
                Color(0xFF764BA2),
              ],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6366F1),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.lock_reset,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Keamanan Akun",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Ubah password Anda untuk menjaga keamanan akun",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Form Section
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Password Lama
                    _buildPasswordField(
                      controller: ubahPasswordC.oldPasswordC.value,
                      label: 'Password Lama',
                      hint: 'Masukkan password lama Anda',
                      isObscure: _isObscureOld,
                      onToggleVisibility: () {
                        setState(() {
                          _isObscureOld = !_isObscureOld;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password lama tidak boleh kosong';
                        }
                        return null;
                      },
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 20),

                    // Password Baru
                    _buildPasswordField(
                      controller: ubahPasswordC.newPasswordC.value,
                      label: 'Password Baru',
                      hint: 'Masukkan password baru (min. 6 karakter)',
                      isObscure: _isObscureNew,
                      onToggleVisibility: () {
                        setState(() {
                          _isObscureNew = !_isObscureNew;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password baru minimal 6 karakter';
                        }
                        return null;
                      },
                      icon: Icons.lock_outline,
                    ),

                    const SizedBox(height: 20),

                    // Konfirmasi Password
                    _buildPasswordField(
                      controller: ubahPasswordC.confirmPasswordC.value,
                      label: 'Konfirmasi Password Baru',
                      hint: 'Masukkan ulang password baru',
                      isObscure: _isObscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _isObscureConfirm = !_isObscureConfirm;
                        });
                      },
                      validator: (value) {
                        if (value != ubahPasswordC.newPasswordC.value.text) {
                          return 'Konfirmasi password tidak cocok';
                        }
                        return null;
                      },
                      icon: Icons.lock_outline,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              Obx(() => GestureDetector(
                    onTap: ubahPasswordC.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              ubahPasswordC.ubahPassword();
                            }
                          },
                    onTapDown: (_) {
                      if (!ubahPasswordC.isLoading.value) {
                        _scaleAnimationController.forward();
                      }
                    },
                    onTapUp: (_) {
                      if (!ubahPasswordC.isLoading.value) {
                        _scaleAnimationController.reverse();
                      }
                    },
                    onTapCancel: () {
                      if (!ubahPasswordC.isLoading.value) {
                        _scaleAnimationController.reverse();
                      }
                    },
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              gradient: ubahPasswordC.isLoading.value
                                  ? null
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFF10B981),
                                        Color(0xFF059669)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                              color: ubahPasswordC.isLoading.value
                                  ? Colors.grey.shade300
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: ubahPasswordC.isLoading.value
                                  ? null
                                  : [
                                      BoxShadow(
                                        color: const Color(0xFF10B981)
                                            .withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (ubahPasswordC.isLoading.value)
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey,
                                      ),
                                    ),
                                  )
                                else
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.save,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                Text(
                                  ubahPasswordC.isLoading.value
                                      ? "Menyimpan..."
                                      : "Simpan Password",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: ubahPasswordC.isLoading.value
                                        ? Colors.grey.shade600
                                        : Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isObscure,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6366F1),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          obscureText: isObscure,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontFamily: 'Poppins',
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFF6366F1),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 2,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey.shade600,
              ),
              onPressed: onToggleVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
