import 'package:flutter/material.dart';

class RankSiswa extends StatelessWidget {
  final List<Student> students = [
    Student(
        name: 'Udin',
        score: 100,
        imageUrl:
            'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/848787eb152360889c84c0f1d3568228a9a3d1b2a3d2f4079cf354ddfa17b0c4?apiKey=7269843b34254a84ac205c1bfd7d31c3&'),
    Student(
        name: 'Febry',
        score: 93,
        imageUrl:
            'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/fdee7165ca68fbc19a299312ebb0444155957c476d7faa4d7e44d01e67253b63?apiKey=7269843b34254a84ac205c1bfd7d31c3&'),
    Student(
        name: 'Umar',
        score: 103,
        imageUrl:
            'https://cdn.builder.io/api/v1/image/assets/7269843b34254a84ac205c1bfd7d31c3/640f39007746474fe29596e116a2d75efc0c6afab8f2ec00cfaac16dbb63de4f?apiKey=7269843b34254a84ac205c1bfd7d31c3&'),
  ];

  RankSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        title: const Text(
          'E-learning',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const RankingSection(),
              const SizedBox(height: 10),
              const SizedBox(height: 62),
              Leaderboard(students: students),
              const SizedBox(height: 40),
              const CongratulationsText(),
              const SizedBox(height: 21),
              ScoreDisplay(
                score: students[1].score,
              ), // Using Febry's score for example
            ],
          ),
        ),
      ),
    );
  }
}

class Student {
  final String name;
  final int score;
  final String imageUrl;

  Student({required this.name, required this.score, required this.imageUrl});
}

class RankingSection extends StatelessWidget {
  const RankingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(left: 0),
        child: Text(
          'Ranking',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  final List<Student> students;

  const Leaderboard({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: students
            .map((student) => Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: _buildLeaderboardItem(student),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLeaderboardItem(Student student) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            student.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 23),
        Text(
          student.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          student.score.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ScoreDisplay extends StatelessWidget {
  final int score;

  const ScoreDisplay({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 196,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 39),
      decoration: BoxDecoration(
        color: const Color(0xFF98DFBD),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Text(
            'SCORE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            score.toString(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class CongratulationsText extends StatelessWidget {
  const CongratulationsText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'hebat Febry!!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
