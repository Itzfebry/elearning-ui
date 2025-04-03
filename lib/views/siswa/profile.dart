import 'package:flutter/material.dart';


class ProfileSiswa extends StatelessWidget {
  const ProfileSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Siswa"),
      ),
      body: const ProfileWidget(),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(42, 116, 42, 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profil',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Febry',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 32),
                      Text(
                        'Kelebihan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 23),
                      Text(
                        'Matematika',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        radius: 38,
                        backgroundImage: NetworkImage('https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/85a37fd6b502cfa6f311cf6cb4af2f561dfa7c5fcbfb1afdd620a50cbfe97ea1?apiKey=7269843b34254a84ac205c1bfd7d31c3&'),
                      ),
                      const SizedBox(height: 30),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: 'Tipe Belajar Kamu : '),
                            TextSpan(
                              text: 'Visual',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        '95%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 17),
              const ProgressBar(progress: 0.95),
              const SizedBox(height: 10),
              const SkillRow(skillName: 'Bahasa Inggris', percentage: '83%'),
              const SizedBox(height: 12),
              const ProgressBar(progress: 0.83),
              const SizedBox(height: 24),
              const Text(
                'Catatan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const NoteCard(
                text: '"Kamu sudah sangat bagus dalam memahami bentuk-bentuk dasar geometri. Kerja Bagus!!\nRekomendasi : Lanjutkan Belajar Ruang 3 Dimensi"',
                highlightedText: 'bentuk-bentuk dasar geometri.',
              ),
              const SizedBox(height: 29),
              const Text(
                'Kekurangan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const SkillRow(skillName: 'Ilmu Pengetahuan Sosial', percentage: '44%'),
              const SizedBox(height: 17),
              const ProgressBar(progress: 0.44),
              const SizedBox(height: 10),
              const SkillRow(skillName: 'Pendidikan Agama Islam', percentage: '40%'),
              const SizedBox(height: 12),
              const ProgressBar(progress: 0.40),
              const SizedBox(height: 22),
              const NoteCard(
                text: 'tingkatkan tentang materi sumber daya manusia dan ilmu tajwid. Pelajari Materi Ilmu Tajwid dan coba tulis di kertas',
                highlightedText: 'sumber daya manusia dan ilmu tajwid.',
              ),
              const SizedBox(height: 34),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFCBCACA),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
                child: Column(
                  children: [
                    Image.network(
                      'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/0ec078c164d711057aced8e3139957cf4a9b9f980819b81536b073e0ee525332?apiKey=7269843b34254a84ac205c1bfd7d31c3&',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      height: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                '3 bulan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFFD7CDCD),
        borderRadius: BorderRadius.circular(40),
      ),
      child: FractionallySizedBox(
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE4FF3F),
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String text;
  final String highlightedText;

  const NoteCard({super.key, required this.text, required this.highlightedText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFFFECBB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: text.substring(0, text.indexOf(highlightedText))),
            TextSpan(
              text: highlightedText,
              style: const TextStyle(color: Colors.red),
            ),
            TextSpan(text: text.substring(text.indexOf(highlightedText) + highlightedText.length)),
          ],
        ),
      ),
    );
  }
}

class SkillRow extends StatelessWidget {
  final String skillName;
  final String percentage;

  const SkillRow({super.key, required this.skillName, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          skillName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}