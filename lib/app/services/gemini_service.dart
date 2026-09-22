import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../modules/ai_tutor/models/ai_chat_message.dart';

class GeminiService {
  static const String _model = 'gemini-3.5-flash-lite';

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
- Matematika yang digunakan untuk menyelesaikan soal kimia

Jika pengguna bertanya sesuatu yang tidak berhubungan dengan kimia, jawab tepat seperti ini:

"Aku khusus membantu topik kimia. Coba tanyakan tentang atom, unsur, reaksi kimia, stoikiometri, pH, atau topik kimia lainnya."

Jangan menjawab isi pertanyaan di luar kimia tersebut.

ATURAN MENJAWAB:
- Gunakan bahasa Indonesia kecuali pengguna meminta bahasa lain dalam konteks pembelajaran kimia.
- Jelaskan konsep dengan sederhana terlebih dahulu.
- Untuk soal hitungan kimia, jelaskan langkah penyelesaiannya secara bertahap.
- Sebutkan rumus yang digunakan jika diperlukan.
- Jangan membuat fakta, nilai, konstanta, atau rumus yang tidak diketahui.
- Jika informasi soal kurang lengkap, jelaskan informasi apa yang masih dibutuhkan.
- Untuk pembahasan praktikum, fokus pada konsep kimia dan keselamatan dasar.
- Jangan menjawab seperti chatbot layanan pelanggan.
- Bertindak seperti tutor kimia yang membantu siswa memahami alasan di balik jawaban.
- Hindari jawaban terlalu panjang untuk pertanyaan sederhana.
- Gunakan format teks sederhana.
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
    final apiKey = _apiKey;

    if (apiKey.isEmpty) {
      throw const GeminiException(
        'GEMINI_API_KEY tidak ditemukan di file .env.',
      );
    }

    if (messages.isEmpty) {
      throw const GeminiException(
        'Tidak ada pesan yang dapat dikirim ke Gemini.',
      );
    }

    final contents = messages
        .map((message) => message.toGeminiContent())
        .toList();

    late http.Response response;

    try {
      response = await http
          .post(
            _endpoint,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': apiKey,
            },
            body: jsonEncode({
              'systemInstruction': {
                'parts': [
                  {'text': _systemInstruction},
                ],
              },
              'contents': contents,
              'generationConfig': {'maxOutputTokens': 1024},
            }),
          )
          .timeout(const Duration(seconds: 30));
    } on Exception catch (error) {
      throw GeminiException('Tidak dapat terhubung ke Gemini API: $error');
    }

    final responseBody = utf8.decode(response.bodyBytes);

    final decoded = _decodeResponse(responseBody, response.statusCode);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GeminiException(_extractApiError(decoded, response.statusCode));
    }

    if (decoded is! Map<String, dynamic>) {
      throw const GeminiException('Format respons Gemini tidak valid.');
    }

    final candidates = decoded['candidates'];

    if (candidates is! List || candidates.isEmpty) {
      final promptFeedback = decoded['promptFeedback'];

      if (promptFeedback is Map<String, dynamic>) {
        final blockReason = promptFeedback['blockReason']?.toString().trim();

        if (blockReason != null && blockReason.isNotEmpty) {
          throw GeminiException(
            'Permintaan diblokir oleh Gemini: $blockReason',
          );
        }
      }

      throw const GeminiException('Gemini tidak memberikan jawaban.');
    }

    final candidate = candidates.first;

    if (candidate is! Map<String, dynamic>) {
      throw const GeminiException('Format jawaban Gemini tidak valid.');
    }

    final content = candidate['content'];

    if (content is! Map<String, dynamic>) {
      final finishReason = candidate['finishReason']?.toString().trim();

      if (finishReason != null && finishReason.isNotEmpty) {
        throw GeminiException(
          'Gemini berhenti tanpa memberikan jawaban. Alasan: $finishReason',
        );
      }

      throw const GeminiException('Gemini tidak memberikan konten jawaban.');
    }

    final parts = content['parts'];

    if (parts is! List || parts.isEmpty) {
      throw const GeminiException('Jawaban Gemini kosong.');
    }

    final textParts = <String>[];

    for (final part in parts) {
      if (part is! Map<String, dynamic>) {
        continue;
      }

      final text = part['text']?.toString().trim();

      if (text != null && text.isNotEmpty) {
        textParts.add(text);
      }
    }

    final result = textParts.join('\n').trim();

    if (result.isEmpty) {
      throw const GeminiException('Gemini tidak menghasilkan teks jawaban.');
    }

    return result;
  }

  dynamic _decodeResponse(String body, int statusCode) {
    if (body.trim().isEmpty) {
      throw GeminiException(
        'Gemini mengembalikan respons kosong. HTTP $statusCode.',
      );
    }

    try {
      return jsonDecode(body);
    } catch (_) {
      throw GeminiException(
        'Respons Gemini tidak dapat dibaca. HTTP $statusCode.',
      );
    }
  }

  String _extractApiError(dynamic decoded, int statusCode) {
    var message = 'Gemini API gagal dengan HTTP $statusCode.';

    if (decoded is! Map<String, dynamic>) {
      return message;
    }

    final error = decoded['error'];

    if (error is! Map<String, dynamic>) {
      return message;
    }

    final apiMessage = error['message']?.toString().trim();

    final status = error['status']?.toString().trim();

    if (apiMessage != null && apiMessage.isNotEmpty) {
      message = apiMessage;
    }

    if (status != null && status.isNotEmpty) {
      return '$status: $message';
    }

    return message;
  }
}

class GeminiException implements Exception {
  final String message;

  const GeminiException(this.message);

  @override
  String toString() {
    return message;
  }
}
