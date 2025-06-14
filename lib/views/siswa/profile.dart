// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui/routes/app_routes.dart';
import 'package:ui/views/siswa/controllers/siswa_controller.dart';

class ProfileSiswa extends StatelessWidget {
  ProfileSiswa({super.key});
  SiswaController siswaC = Get.find<SiswaController>();

  @override
  Widget build(BuildContext context) {
    siswaC.getAnalysis();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Gradien warna untuk ProfileHeader
    final List<Color> gradientColors = isDarkMode 
      ? [const Color.fromARGB(255, 221, 241, 221), const Color.fromARGB(255, 244, 244, 244)]
      : [const Color.fromARGB(255, 209, 250, 209), const Color.fromARGB(255, 68, 154, 118)];
    
    // Warna untuk tombol
    final Color buttonColor1 = isDarkMode ? const Color.fromARGB(255, 111, 158, 205) : Colors.blue.shade400;
    final Color buttonColor2 = isDarkMode ? Colors.red.shade700 : Colors.red.shade400;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Profil Siswa'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: gradientColors[0],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await siswaC.getAnalysis();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header profil dengan gradient
              _buildProfileHeader(gradientColors, isDarkMode, isTablet),
              
              // Konten utama
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? size.width * 0.1 : 16,
                  vertical: 16
                ),
                child: Column(
                  children: [
                    // Card untuk konten analisis
                    _buildAnalysisCard(context, isDarkMode, isTablet),
                    
                    SizedBox(height: isTablet ? 32 : 24),
                    
                    // Tombol-tombol aksi
                    _buildActionButtons(
                      context, 
                      buttonColor1, 
                      buttonColor2, 
                      textColor, 
                      isTablet
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    List<Color> gradientColors, 
    bool isDarkMode, 
    bool isTablet
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 40 : 24, 
        horizontal: isTablet ? 40 : 16
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          children: [
            Hero(
              tag: 'profile_avatar',
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: isTablet ? 70 : 50,
                  backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  child: Icon(
                    Icons.person, 
                    size: isTablet ? 70 : 50,
                    color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              siswaC.dataUser['user']['nama'],
              style: TextStyle(
                fontSize: isTablet ? 26 : 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12, 
                vertical: 4
              ),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Kelas ${siswaC.dataUser['user']['kelas']}',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Colors.white70,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  siswaC.dataUser['user']['user']['email'].toString(),
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(BuildContext context, bool isDarkMode, bool isTablet) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Obx(
          () {
            if (siswaC.isLoadingAnalysis.value) {
              return Container(
                height: 200,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: isDarkMode ? Colors.blue.shade300 : Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Mengambil data analisis...',
                      style: TextStyle(color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700),
                    )
                  ],
                ),
              );
            }
            
            var kelebihan = siswaC.dataAnalysis['kelebihan'];
            var kekurangan = siswaC.dataAnalysis['kekurangan'];

            return Column(
              children: [
                if (siswaC.kelebihanIsEmpty.value)
                  const SizedBox()
                else
                  Column(children: [
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: Colors.green,
                          size: isTablet ? 28 : 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Kelebihan',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: siswaC.dataAnalysis['kelebihan'].length,
                      itemBuilder: (context, index) {
                        return AnimatedProgressItem(
                          title: kelebihan[index]['mapel'],
                          percentage: kelebihan[index]['persentase'],
                          color: Colors.green,
                          isDarkMode: isDarkMode,
                          isTablet: isTablet,
                          animationDelay: (index * 200),
                        );
                      },
                    ),
                  ]),
                  
                if (siswaC.kekuranganIsEmpty.value)
                  const SizedBox()
                else
                  Column(children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Icon(
                          Icons.trending_down,
                          color: Colors.red,
                          size: isTablet ? 28 : 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Kekurangan',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: siswaC.dataAnalysis['kekurangan'].length,
                      itemBuilder: (context, index) {
                        return AnimatedProgressItem(
                          title: kekurangan[index]['mapel'],
                          percentage: kekurangan[index]['persentase'],
                          color: Colors.red,
                          isDarkMode: isDarkMode,
                          isTablet: isTablet,
                          animationDelay: (index * 200) + 500,
                        );
                      },
                    ),
                  ]),
                
                if (siswaC.kelebihanIsEmpty.value && siswaC.kekuranganIsEmpty.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(
                          Icons.analytics_outlined,
                          size: 60,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada data analisis',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context, 
    Color buttonColor1, 
    Color buttonColor2, 
    Color textColor,
    bool isTablet
  ) {
    return Column(
      children: [
        // Tombol Ubah Password
        ElevatedButton.icon(
          onPressed: () {
            Get.toNamed(AppRoutes.ubahPassord);
          },
          icon: const Icon(Icons.lock_reset),
          label: Text(
            'Ubah Password',
            style: TextStyle(
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: buttonColor1,
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 18 : 16, 
              horizontal: isTablet ? 32 : 24
            ),
            minimumSize: Size(isTablet ? 300 : double.infinity, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        
        SizedBox(height: isTablet ? 20 : 16),
        
        // Tombol Logout
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Konfirmasi Logout'),
                content: const Text('Apakah Anda yakin ingin logout?'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(); // Tutup dialog
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      siswaC.logout(role: "siswa");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor2,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.logout),
          label: Text(
            'Logout',
            style: TextStyle(
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: buttonColor2,
            padding: EdgeInsets.symmetric(
              vertical: isTablet ? 18 : 16, 
              horizontal: isTablet ? 32 : 24
            ),
            minimumSize: Size(isTablet ? 300 : double.infinity, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
      ],
    );
  }
}

// Widget untuk progress item dengan animasi
class AnimatedProgressItem extends StatefulWidget {
  final String title;
  final int percentage;
  final Color color;
  final bool isDarkMode;
  final bool isTablet;
  final int animationDelay;

  const AnimatedProgressItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.color,
    required this.isDarkMode,
    required this.isTablet,
    this.animationDelay = 0,
  });

  @override
  State<AnimatedProgressItem> createState() => _AnimatedProgressItemState();
}

class _AnimatedProgressItemState extends State<AnimatedProgressItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.percentage / 100)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));

    // Tunda animasi sesuai dengan delay yang diberikan
    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: widget.isTablet ? 18 : 16,
      fontWeight: FontWeight.w500,
      color: widget.isDarkMode ? Colors.white : Colors.black87,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: textStyle),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Text(
                    '${(_animation.value * 100).toInt()}%',
                    style: textStyle.copyWith(
                      color: widget.color,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _animation.value,
                  backgroundColor: widget.color.withOpacity(0.2),
                  color: widget.color,
                  minHeight: widget.isTablet ? 12 : 10,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}