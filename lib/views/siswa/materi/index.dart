import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MateriView extends StatelessWidget {
  MateriView({super.key});
  final List<Map<String, String>> materiList = [
    {
      'judul': 'Materi Pemrograman Flutter',
      'tanggal': '10 April 2025',
      'fileUrl': 'https://example.com/flutter.pdf',
    },
    {
      'judul': 'Materi Machine Learning',
      'tanggal': '12 April 2025',
      'fileUrl': 'https://example.com/ml.pdf',
    },
  ];

  final List<Map<String, String>> videoList = [
    {
      'url': 'https://www.youtube.com/watch?v=-LXyD5cOuoM',
      'judul': 'Belajar Flutter Dasar',
      'desc': 'Video ini membahas dasar-dasar Flutter.'
    },
    {
      'url': 'https://www.youtube.com/watch?v=tHIffjpnoM0',
      'judul': 'State Management di Flutter',
      'desc': 'Penjelasan lengkap tentang State Management.'
    },
  ];

  // Fungsi untuk membuka link YouTube di browser
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Materi & Video'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Materi', icon: Icon(Icons.book)),
              Tab(text: 'Video', icon: Icon(Icons.video_collection)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab Materi
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: materiList.length,
              itemBuilder: (context, index) {
                final materi = materiList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(materi['judul']!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('Tanggal: ${materi['tanggal']}'),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            // handle download
                          },
                          icon: const Icon(Icons.download),
                          label: const Text("Download Materi"),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),

            // Tab Video
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                final video = videoList[index];
                final videoId = Uri.parse(video['url']!).queryParameters['v'];

                // Thumbnail URL
                final thumbnailUrl =
                    'https://img.youtube.com/vi/$videoId/0.jpg';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL(video['url']!);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(thumbnailUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        video['judul']!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(video['desc']!),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
