import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatpelQuizDetail extends StatelessWidget {
  const MatpelQuizDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz ${Get.arguments['matpel']}"),
      ),
    );
  }
}
