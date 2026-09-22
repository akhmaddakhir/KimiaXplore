import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../modules/ai_tutor/models/ai_chat_message.dart';

class GeminiService {
  static const String _model = 'gemini-2.5-flash';

  static const String _systemInstruction = '''
Kamu adalah Kimi, AI Tutor resmi di aplikasi KimiaXplore.

Tugas utama kamu adalah membantu pelajar SMA dan SMK memahami kimia dengan bahasa Indonesia yang sederhana, ramah, jelas, dan mudah dipahami.

ATURAN DOMAIN:
Kamu hanya boleh menjawab pertanyaan yang berhubungan dengan kimia.

Topik yang boleh kamu bantu meliputi:
- Struktur atom
- Partikel penyusun atom
- Nomor atom dan nomor massa
- Isotop dan ion
- Sistem periodik unsur
- Konfigurasi elektron
- Ikatan kimia
- Reaksi kimia
- Penyetaraan reaksi
- Stoikiometri
- Mol dan massa molar
- Larutan
- Konsentrasi
- Asam dan basa
- pH
- Redoks
- Termokimia
- Kesetimbangan kimia
- Laju reaksi
- Kimia organik dasar
- Materi kimia SMA dan SMK lainnya
- Matematika yang diperlukan untuk menyelesaikan soal kimia

Jika pengguna bertanya sesuatu yang tidak berhubungan dengan kimia, jangan menjawab pertanyaan tersebut.

Untuk pertanyaan di luar kimia, jawab dengan tepat seperti ini:

"Aku khusus membantu topik kimia. Coba tanyakan tentang atom, unsur, reaksi kimia, stoikiometri, pH, atau topik kimia lainnya."

Jangan melanjutkan dengan penjelasan tentang topik di luar kimia.

ATURAN MENJAWAB:
- Gunakan bahasa Indonesia kecuali pengguna meminta bahasa lain dalam konteks pembelajaran kimia.
- Jelaskan konsep dengan sederhana terlebih dahulu.
- Untuk soal hitungan kimia, jelaskan langkah penyelesaiannya secara bertahap.
- Sebutkan rumus yang digunakan jika diperlukan.
- Jangan membuat fakta, nilai, konstanta, atau rumus yang tidak diketahui.
- Jika informasi soal kurang lengkap, jelaskan informasi apa yang masih dibutuhkan.
- Jangan memberikan prosedur eksperimen berbahaya.
- Untuk pembahasan praktikum, fokus pada konsep kimia dan keselamatan dasar.
- Jangan menjawab seperti chatbot layanan pelanggan.
- Bertindaklah seperti tutor kimia yang membantu siswa memahami alasan di balik jawaban.
- Hindari jawaban yang terlalu panjang jika pertanyaannya sederhana.
- Jangan menggunakan markdown yang rumit.
''';

  String get _apiKey {
    return dotenv.env['GEMINI_API_KEY']?.trim() ?? '';
  }

  Uri get _endpoint {
    return Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent',
    );
  }

  Future<String> generateReply(List<AiChatMessage> messages) async {
    if (_apiKey.isEmpty) {
      throw StateError('GEMINI_API_KEY belum dikonfigurasi');
    }

    final contents = messages
        .map((message) => message.toGeminiContent())
        .toList();

    final response = await http
        .post(
          _endpoint,
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': _apiKey,
          },
          body: jsonEncode({
            'systemInstruction': {
              'parts': [
                {'text': _systemInstruction},
              ],
            },
            'contents': contents,
            'generationConfig': {'temperature': 0.35, 'maxOutputTokens': 1024},
          }),
        )
        .timeout(const Duration(seconds: 30));

    final bodyText = utf8.decode(response.bodyBytes);

    final decoded = jsonDecode(bodyText);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String message = 'Gemini request gagal';

      if (decoded is Map<String, dynamic>) {
        final error = decoded['error'];

        if (error is Map<String, dynamic>) {
          final errorMessage = error['message'];

          if (errorMessage is String && errorMessage.isNotEmpty) {
            message = errorMessage;
          }
        }
      }

      throw Exception(message);
    }

    if (decoded is! Map<String, dynamic>) {
      throw Exception('Format respons Gemini tidak valid');
    }

    final candidates = decoded['candidates'];

    if (candidates is! List || candidates.isEmpty) {
      throw Exception('Gemini tidak memberikan jawaban');
    }

    final firstCandidate = candidates.first;

    if (firstCandidate is! Map<String, dynamic>) {
      throw Exception('Respons Gemini tidak valid');
    }

    final content = firstCandidate['content'];

    if (content is! Map<String, dynamic>) {
      throw Exception('Konten Gemini tidak ditemukan');
    }

    final parts = content['parts'];

    if (parts is! List || parts.isEmpty) {
      throw Exception('Jawaban Gemini kosong');
    }

    final responseParts = <String>[];

    for (final part in parts) {
      if (part is! Map<String, dynamic>) {
        continue;
      }

      final text = part['text'];

      if (text is String && text.trim().isNotEmpty) {
        responseParts.add(text.trim());
      }
    }

    final result = responseParts.join('\n').trim();

    if (result.isEmpty) {
      throw Exception('Jawaban Gemini kosong');
    }

    return result;
  }
}
