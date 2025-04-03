class User {
  final String? id;
  final String nama;
  final String email;
  final String role;
  final String? nis;
  final String? kelasId;
  final String? kelasNama;
  final String nomorTelepon;
  final String status;
  final String? profilGambar;
  final DateTime? tanggalBergabung;

  User({
    this.id,
    required this.nama,
    required this.email,
    required this.role,
    this.nis,
    this.kelasId,
    this.kelasNama,
    required this.nomorTelepon,
    required this.status,
    this.profilGambar,
    this.tanggalBergabung,
  });

  // Factory method untuk parsing JSON ke objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      nama: json['nama'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'Unknown',
      role: json['role'] as String? ?? 'User',
      nis: json['nis'] as String?,
      kelasId: json['kelas_id']?['_id'] as String? ?? json['kelas_id'] as String?,
      kelasNama: json['kelas_id']?['nama'] as String?,
      nomorTelepon: json['nomor_telepon'] as String? ?? '',
      status: json['status'] as String? ?? 'Aktif',
      profilGambar: json['profil_gambar'] as String?,
      tanggalBergabung: json['tanggal_bergabung'] != null
          ? DateTime.tryParse(json['tanggal_bergabung'])
          : null,
    );
  }

  // Konversi objek User ke JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nama': nama,
      'email': email,
      'role': role,
      'nis': nis,
      'kelas_id': kelasId,
      'nomor_telepon': nomorTelepon,
      'status': status,
      'profil_gambar': profilGambar,
      'tanggal_bergabung': tanggalBergabung?.toIso8601String(),
    };
  }

  // Fungsi untuk mengupdate sebagian data User tanpa membuat instance baru
  User copyWith({
    String? id,
    String? nama,
    String? email,
    String? role,
    String? nis,
    String? kelasId,
    String? kelasNama,
    String? nomorTelepon,
    String? status,
    String? profilGambar,
    DateTime? tanggalBergabung,
  }) {
    return User(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      role: role ?? this.role,
      nis: nis ?? this.nis,
      kelasId: kelasId ?? this.kelasId,
      kelasNama: kelasNama ?? this.kelasNama,
      nomorTelepon: nomorTelepon ?? this.nomorTelepon,
      status: status ?? this.status,
      profilGambar: profilGambar ?? this.profilGambar,
      tanggalBergabung: tanggalBergabung ?? this.tanggalBergabung,
    );
  }
}
