import 'package:flutter/material.dart';

class SoalQuiz extends StatelessWidget {
  const SoalQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soal Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kotak Soal (Teks)
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Apa ibu kota Indonesia?', // <-- Ini teks soal
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Pilihan Jawaban
              buildJawaban('A. Jakarta'),
              buildJawaban('B. Surabaya'),
              buildJawaban('C. Bandung'),
              buildJawaban('D. Medan'),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk kotak jawaban
  Widget buildJawaban(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
