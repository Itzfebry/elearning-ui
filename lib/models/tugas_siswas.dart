class TugasSiswa {
  String id;
  String tugasGuruId;
  String siswaId;
  String fileUrl;
  String? komentar;
  String status;
  int? nilai;
  String? feedback;
  DateTime? submittedAt;
  DateTime? gradedAt;

  TugasSiswa({
    required this.id,
    required this.tugasGuruId,
    required this.siswaId,
    required this.fileUrl,
    this.komentar,
    required this.status,
    this.nilai,
    this.feedback,
    this.submittedAt,
    this.gradedAt,
  });

  factory TugasSiswa.fromJson(Map<String, dynamic> json) {
    return TugasSiswa(
      id: json['_id'],
      tugasGuruId: json['tugas_guru_id'],
      siswaId: json['siswa_id'],
      fileUrl: json['file_url'],
      komentar: json['komentar'],
      status: json['status'],
      nilai: json['nilai'],
      feedback: json['feedback'],
      submittedAt: json['submitted_at'] != null ? DateTime.parse(json['submitted_at']) : null,
      gradedAt: json['graded_at'] != null ? DateTime.parse(json['graded_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tugas_guru_id': tugasGuruId,
      'siswa_id': siswaId,
      'file_url': fileUrl,
      'komentar': komentar,
      'status': status,
      'nilai': nilai,
      'feedback': feedback,
      'submitted_at': submittedAt?.toIso8601String(),
      'graded_at': gradedAt?.toIso8601String(),
    };
  }
}
