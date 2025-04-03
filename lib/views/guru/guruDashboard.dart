import 'package:flutter/material.dart';

class GuruDashboardPage extends StatelessWidget {
  const GuruDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Guru'),
      ),
      body: const Center(
        child: Text('Selamat datang di Dashboard Guru!'),
      ),
    );
  }
}
