# Implementasi Quiz Auto-Stop ketika Soal Habis di Level

## Deskripsi

Implementasi ini menambahkan fitur untuk menghentikan quiz otomatis ketika soal habis di level tertentu. Sistem akan mendeteksi response 404 atau pesan khusus dari backend dan secara otomatis menghentikan timer, menampilkan pesan ke user, dan menyelesaikan quiz.

## File yang Dimodifikasi

### 1. `lib/views/siswa/quiz/controllers/quiz_question_controller.dart`

#### Perubahan Utama:

- **Penanganan Response 404**: Menambahkan logika khusus untuk mendeteksi ketika soal habis di level tertentu
- **Penanganan Response 204**: Menambahkan penanganan untuk status 204 No Content
- **Pengecekan Pesan Response**: Memeriksa pesan dalam response body untuk mendeteksi soal habis
- **Method `handleQuestionsExhausted()`**: Method baru untuk menangani ketika soal habis
- **Method `autoFinishQuiz()`**: Method untuk menyelesaikan quiz otomatis

#### Logika Deteksi Soal Habis:

```dart
// Cek status code 404
if (response.statusCode == 404) {
  String responseBody = response.body.toLowerCase();
  if (responseBody.contains("tidak ada soal lagi di level ini") ||
      responseBody.contains("soal habis") ||
      responseBody.contains("questions exhausted")) {
    await handleQuestionsExhausted(attemptId);
  }
}

// Cek status code 204
if (response.statusCode == 204) {
  await handleQuestionsExhausted(attemptId);
}

// Cek pesan dalam response 200
if (json.containsKey('message')) {
  String message = json['message'].toString().toLowerCase();
  if (message.contains("tidak ada soal lagi di level ini") ||
      message.contains("soal habis") ||
      message.contains("questions exhausted") ||
      message.contains("no more questions")) {
    await handleQuestionsExhausted(attemptId);
  }
}
```

### 2. `lib/views/siswa/quiz/controllers/quiz_attempt_controller.dart`

#### Perubahan Utama:

- **Method `stopQuizTimer()`**: Method baru untuk menghentikan timer quiz yang dapat dipanggil dari controller lain

## Alur Kerja

### 1. Deteksi Soal Habis

Sistem akan mendeteksi soal habis melalui:

- **Status Code 404** dengan pesan "Tidak ada soal lagi di level ini"
- **Status Code 204** (No Content)
- **Status Code 200** dengan pesan soal habis dalam response body

### 2. Penanganan Soal Habis

Ketika soal habis terdeteksi:

1. **Hentikan Timer**: Memanggil `stopQuizTimer()` untuk menghentikan countdown
2. **Tampilkan Pesan**: Menampilkan dialog "Soal sudah habis di level ini, quiz selesai"
3. **Auto Finish Quiz**:
   - Kirim jawaban kosong untuk soal yang belum dijawab
   - Panggil endpoint auto-finish quiz
   - Redirect ke halaman hasil quiz

### 3. Auto Finish Process

```dart
Future<void> autoFinishQuiz(String attemptId) async {
  // 1. Kirim jawaban kosong untuk soal yang belum dijawab
  for (String qid in quizAttemptC.allQuestionIds) {
    if (!quizAttemptC.answeredQuestions.containsKey(qid)) {
      await quizAttemptC.postQuizAttemptAnswer(
        quizAttemptId: attemptId,
        questionId: qid,
        jawabanSiswa: "",
      );
    }
  }

  // 2. Panggil endpoint auto-finish
  final response = await http.post(
    Uri.parse("${ApiConstants.quizAutoFinishEnpoint}/$attemptId"),
    headers: headers,
  );

  // 3. Redirect ke halaman hasil
  if (response.statusCode == 200) {
    Get.offAllNamed('/quiz-selesai', arguments: {'quiz_id': quizId});
  }
}
```

## Pesan yang Didukung

Sistem akan mendeteksi soal habis berdasarkan pesan berikut dalam response:

- "Tidak ada soal lagi di level ini"
- "Soal habis"
- "Questions exhausted"
- "No more questions"

## Error Handling

### 1. Network Error

Jika terjadi error koneksi saat auto-finish:

- Tampilkan dialog error koneksi
- Berikan opsi untuk kembali ke dashboard

### 2. Auto-Finish Failure

Jika auto-finish gagal:

- Tampilkan dialog error
- Berikan opsi untuk kembali ke dashboard

### 3. Fallback

Jika terjadi error dalam penanganan soal habis:

- Langsung redirect ke halaman quiz selesai

## Testing

### Test Cases yang Harus Diuji:

1. **Response 404 dengan pesan soal habis**

   - Backend mengembalikan 404 + "Tidak ada soal lagi di level ini"
   - Timer harus berhenti
   - Dialog pesan harus muncul
   - Quiz harus auto-finish

2. **Response 204 No Content**

   - Backend mengembalikan 204
   - Timer harus berhenti
   - Quiz harus auto-finish

3. **Response 200 dengan pesan soal habis**

   - Backend mengembalikan 200 + message soal habis
   - Timer harus berhenti
   - Quiz harus auto-finish

4. **Response 404 tanpa pesan soal habis**

   - Backend mengembalikan 404 tanpa pesan khusus
   - Tampilkan error dialog umum
   - Tidak auto-finish

5. **Network error saat auto-finish**
   - Simulasi network error
   - Tampilkan error dialog
   - Berikan opsi kembali ke dashboard

## Logging

Sistem menambahkan logging yang detail untuk debugging:

```dart
log("404 - Soal habis di level ini detected");
log("Confirmed: Questions exhausted at this level");
log("Quiz timer stopped");
log("Auto finishing quiz for attempt ID: $attemptId");
log("Auto finish success: $json");
```

## Dependencies

Implementasi ini menggunakan:

- `GetX` untuk state management dan navigation
- `http` package untuk API calls
- `shared_preferences` untuk menyimpan data lokal
- `dart:async` untuk timer management

## Catatan Penting

1. **Timer Management**: Timer quiz akan dihentikan secara otomatis ketika soal habis terdeteksi
2. **User Experience**: User akan mendapat notifikasi yang jelas bahwa quiz selesai karena soal habis
3. **Data Integrity**: Semua soal yang belum dijawab akan dikirim dengan jawaban kosong
4. **Error Recovery**: Sistem memiliki fallback untuk menangani berbagai jenis error
5. **Logging**: Semua proses dicatat dengan detail untuk memudahkan debugging
