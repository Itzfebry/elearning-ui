class KelasMataPelajaran {
  final String id;
  final String kelasId;
  final String mataPelajaranId;
  final String guruId;
  final int semester;
  final int materiCount;
  final int videoCount;
  final String lastUpdated;

  KelasMataPelajaran({
    required this.id,
    required this.kelasId,
    required this.mataPelajaranId,
    required this.guruId,
    required this.semester,
    required this.materiCount,
    required this.videoCount,
    required this.lastUpdated,
  });

  factory KelasMataPelajaran.fromJson(Map<String, dynamic> json) {
    return KelasMataPelajaran(
      id: json['_id'] ?? '',  // Jika '_id' null, beri string kosong
      kelasId: json['kelas'] ?? '',  // Jika 'kelas' null, beri string kosong
      mataPelajaranId: json['mataPelajaran'] ?? '',  // Jika 'mataPelajaran' null, beri string kosong
      guruId: json['guru'] ?? '',  // Jika 'guru' null, beri string kosong
      semester: json['semester'] ?? 0,  // Jika 'semester' null, beri nilai 0
      materiCount: json['materiCount'] ?? 0,  // Jika 'materiCount' null, beri nilai 0
      videoCount: json['videoCount'] ?? 0,  // Jika 'videoCount' null, beri nilai 0
      lastUpdated: json['updatedAt'] ?? '',  // Jika 'updatedAt' null, beri string kosong
    );
  }
}
