// import 'package:flutter/material.dart';
// import 'package:ui/models/matapelajarans.dart';
// import 'package:ui/services/matapelajarans.dart';
// import 'package:ui/views/siswa/tugas/tugas_detail.dart'; // Import halaman detail tugas

// class Tugas extends StatefulWidget {
//   const Tugas({super.key});

//   @override
//   _TugasState createState() => _TugasState();
// }

// class _TugasState extends State<Tugas> {
//   final MatapelajaranService _service = MatapelajaranService();
//   List<MataPelajaran> mataPelajaranList = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchMataPelajaran();
//   }

//   Future<void> fetchMataPelajaran() async {
//     try {
//       List<MataPelajaran> data = await _service.getMatapelajaran();
//       setState(() {
//         mataPelajaranList = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Tugas")),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Tugas',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: isLoading
//                     ? const Center(child: CircularProgressIndicator())
//                     : TaskList(mataPelajaranList: mataPelajaranList),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TaskList extends StatelessWidget {
//   final List<MataPelajaran> mataPelajaranList;

//   const TaskList({super.key, required this.mataPelajaranList});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFBBDBD0),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       padding: const EdgeInsets.fromLTRB(23, 19, 23, 40),
//       child: ListView.builder(
//         itemCount: mataPelajaranList.length,
//         itemBuilder: (context, index) {
//           final matapelajaran = mataPelajaranList[index];
//           return TaskItem(
//             title: matapelajaran.name,
//             mataPelajaranId: matapelajaran.id, // Kirim ID ke halaman detail
//           );
//         },
//       ),
//     );
//   }
// }

// class TaskItem extends StatelessWidget {
//   final String title;
//   final String mataPelajaranId; // ID mata pelajaran

//   const TaskItem({super.key, required this.title, required this.mataPelajaranId});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigasi ke halaman detail tugas
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TugasDetail(mataPelajaranId: mataPelajaranId),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 40),
//         margin: const EdgeInsets.only(bottom: 16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF67DEAC),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Poppins',
//           ),
//         ),
//       ),
//     );
//   }
// }
