import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MateriView extends StatefulWidget {
  const MateriView({super.key});

  @override
  State<MateriView> createState() => _MateriViewState();
}

class _MateriViewState extends State<MateriView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isMateriLoaded = false;
  bool isVideoLoaded = false;

  List<Map<String, String>> materiList = [];
  List<Map<String, String>> videoList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // add listener untuk tab perubahan
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // biar gak dua kali

      if (_tabController.index == 0 && !isMateriLoaded) {
        _loadMateri();
      } else if (_tabController.index == 1 && !isVideoLoaded) {
        _loadVideo();
      }
    });

    // Optionally load tab pertama langsung
    _loadMateri();
  }

  void _loadMateri() {
    setState(() {
      isMateriLoaded = true;
      materiList = [
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
    });
  }

  void _loadVideo() {
    setState(() {
      isVideoLoaded = true;
      videoList = [
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
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi & Video'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Materi', icon: Icon(Icons.book)),
            Tab(text: 'Video', icon: Icon(Icons.video_collection)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Materi
          isMateriLoaded
              ? ListView.builder(
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
                            Text(
                              materi['judul']!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('Tanggal: ${materi['tanggal']}'),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                _launchUrl(materi['fileUrl']!);
                              },
                              icon: const Icon(Icons.download),
                              label: const Text("Download Materi"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator()),

          // Tab Video
          isVideoLoaded
              ? ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: videoList.length,
                  itemBuilder: (context, index) {
                    final video = videoList[index];
                    final videoId =
                        Uri.parse(video['url']!).queryParameters['v'];
                    final thumbnailUrl =
                        'https://img.youtube.com/vi/$videoId/0.jpg';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            _launchUrl(video['url']!);
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
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
