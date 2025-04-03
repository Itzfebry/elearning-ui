import 'package:flutter/material.dart';
import 'package:ui/models/videos.dart';
import 'package:ui/services/videos.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosSiswaPage extends StatefulWidget {
  final String mataPelajaranId;

  const VideosSiswaPage({super.key, required this.mataPelajaranId});

  @override
  _VideosSiswaPageState createState() => _VideosSiswaPageState();
}

class _VideosSiswaPageState extends State<VideosSiswaPage> {
  final VideoService _service = VideoService();
  List<Video> videoList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      List<Video> data = await _service.getVideosByMataPelajaran(widget.mataPelajaranId);
      setState(() {
        videoList = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _openVideo(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Tidak bisa membuka video: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Video"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videoList.length,
              itemBuilder: (context, index) {
                Video video = videoList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: ListTile(
                    title: Text(video.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(video.description ?? "Tidak ada deskripsi"),
                    trailing: const Icon(Icons.play_circle_fill, color: Colors.redAccent),
                    onTap: () {
                      _openVideo(video.videoUrl);
                    },
                  ),
                );
              },
            ),
    );
  }
}
