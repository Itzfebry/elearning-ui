// import 'package:flutter/material.dart';
// import 'package:ui/services/user_services.dart';
// import 'package:ui/models/user.dart';

// class RuangDiskusi extends StatefulWidget {
//   @override
//   _RuangDiskusiState createState() => _RuangDiskusiState();
// }

// class _RuangDiskusiState extends State<RuangDiskusi> {
//   final UserService userService = UserService();
//   late Future<List<User>> futureUsers;

//   @override
//   void initState() {
//     super.initState();
//     futureUsers = userService.getUsers();
//   }

//   void refreshUsers() {
//     setState(() {
//       futureUsers = userService.getUsers();
//     });
//   }

//   void _showForm({User? user}) {
//     final TextEditingController nameController = TextEditingController(text: user?.name ?? "");
//     final TextEditingController emailController = TextEditingController(text: user?.email ?? "");
//     final TextEditingController roleController = TextEditingController(text: user?.role ?? "siswa");

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(user == null ? "Tambah User" : "Edit User"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: nameController, decoration: InputDecoration(labelText: "Nama")),
//             TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
//             TextField(controller: roleController, decoration: InputDecoration(labelText: "Role")),
//           ],
//         ),
//         actions: [
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               if (user == null) {
//                 await userService.addUser(User(id: "", name: nameController.text, email: emailController.text, role: roleController.text));
//               } else {
//                 await userService.updateUser(user.id, User(id: user.id, name: nameController.text, email: emailController.text, role: roleController.text));
//               }
//               refreshUsers();
//             },
//             child: Text(user == null ? "Tambah" : "Update"),
//           ),
//         ],
//       ),
//     );
//   }

//   void _confirmDelete(String id) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Hapus User?"),
//         content: Text("Apakah kamu yakin ingin menghapus user ini?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Batal"),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await userService.deleteUser(id);
//               refreshUsers();
//             },
//             child: Text("Hapus"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Ruang Diskusi")),
//       body: FutureBuilder<List<User>>(
//         future: futureUsers,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Gagal memuat data"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("Tidak ada data siswa"));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 User user = snapshot.data![index];
//                 return ListTile(
//                   title: Text(user.name),
//                   subtitle: Text("${user.email} - ${user.role}"),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(icon: Icon(Icons.edit), onPressed: () => _showForm(user: user)),
//                       IconButton(icon: Icon(Icons.delete), onPressed: () => _confirmDelete(user.id)),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showForm(),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
