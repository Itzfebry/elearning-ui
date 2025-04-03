class TugasGuru {
  String id;
  String guruId;
  String mataPelajaranId;
  String materiId;
  String judul;
  String deskripsi;
  int bobotNilai;
  String? attachmentUrl;
  DateTime deadline;
  int maxFileSize;
  List<String> allowedFileTypes;
  bool isPublished;
  DateTime createdAt;
  DateTime updatedAt;

  TugasGuru({
    required this.id,
    required this.guruId,
    required this.mataPelajaranId,
    required this.materiId,
    required this.judul,
    required this.deskripsi,
    required this.bobotNilai,
    this.attachmentUrl,
    required this.deadline,
    required this.maxFileSize,
    required this.allowedFileTypes,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TugasGuru.fromJson(Map<String, dynamic> json) {
    return TugasGuru(
      id: json['_id'],
      guruId: json['guru_id'],
      mataPelajaranId: json['mata_pelajaran_id'],
      materiId: json['materi_id'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      bobotNilai: json['bobot_nilai'],
      attachmentUrl: json['attachment_url'],
      deadline: DateTime.parse(json['deadline']),
      maxFileSize: json['max_file_size'],
      allowedFileTypes: List<String>.from(json['allowed_file_types']),
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guru_id': guruId,
      'mata_pelajaran_id': mataPelajaranId,
      'materi_id': materiId,
      'judul': judul,
      'deskripsi': deskripsi,
      'bobot_nilai': bobotNilai,
      'attachment_url': attachmentUrl,
      'deadline': deadline.toIso8601String(),
      'max_file_size': maxFileSize,
      'allowed_file_types': allowedFileTypes,
      'is_published': isPublished,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
