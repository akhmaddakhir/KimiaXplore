import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../modules/ai_tutor/models/ai_chat_message.dart';

class GeminiService {
  static const String _model = 'gemini-3.5-flash-lite';

  String get _apiKey {
    return dotenv.env['GEMINI_API_KEY']?.trim() ?? '';
  }

  Uri get _endpoint {
    return Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent',
    );
  }

  Future<String> generateReply(
    List<AiChatMessage> messages, {
    required String language,
  }) async {
    final apiKey = _apiKey;

    if (apiKey.isEmpty) {
      throw GeminiException(
        language == 'EN'
            ? 'GEMINI_API_KEY was not found in the .env file.'
            : 'GEMINI_API_KEY tidak ditemukan di file .env.',
      );
    }

    if (messages.isEmpty) {
      throw GeminiException(
        language == 'EN'
            ? 'There are no messages to send to Gemini.'
            : 'Tidak ada pesan yang dapat dikirim ke Gemini.',
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
                  {'text': _buildSystemInstruction(language)},
                ],
              },
              'contents': contents,
              'generationConfig': {'maxOutputTokens': 1024},
            }),
          )
          .timeout(const Duration(seconds: 30));
    } on Exception catch (error) {
      throw GeminiException(
        language == 'EN'
            ? 'Unable to connect to Gemini API: $error'
            : 'Tidak dapat terhubung ke Gemini API: $error',
      );
    }

    final responseBody = utf8.decode(response.bodyBytes);

    final decoded = _decodeResponse(
      responseBody,
      response.statusCode,
      language,
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw GeminiException(
        _extractApiError(decoded, response.statusCode, language),
      );
    }

    if (decoded is! Map<String, dynamic>) {
      throw GeminiException(
        language == 'EN'
            ? 'Invalid Gemini response format.'
            : 'Format respons Gemini tidak valid.',
      );
    }

    final candidates = decoded['candidates'];

    if (candidates is! List || candidates.isEmpty) {
      throw GeminiException(
        language == 'EN'
            ? 'Gemini did not provide an answer.'
            : 'Gemini tidak memberikan jawaban.',
      );
    }

    final candidate = candidates.first;

    if (candidate is! Map<String, dynamic>) {
      throw GeminiException(
        language == 'EN'
            ? 'Invalid Gemini answer format.'
            : 'Format jawaban Gemini tidak valid.',
      );
    }

    final content = candidate['content'];

    if (content is! Map<String, dynamic>) {
      throw GeminiException(
        language == 'EN'
            ? 'Gemini did not provide answer content.'
            : 'Gemini tidak memberikan konten jawaban.',
      );
    }

    final parts = content['parts'];

    if (parts is! List || parts.isEmpty) {
      throw GeminiException(
        language == 'EN'
            ? 'Gemini returned an empty answer.'
            : 'Jawaban Gemini kosong.',
      );
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
      throw GeminiException(
        language == 'EN'
            ? 'Gemini did not generate a text answer.'
            : 'Gemini tidak menghasilkan teks jawaban.',
      );
    }

    return result;
  }

  String _buildSystemInstruction(String language) {
    if (language == 'EN') {
      return '''
You are Kimi, the official AI Tutor in KimiaXplore.

Your main role is to help high school and vocational school students understand chemistry clearly and simply.

DOMAIN RULES:
You may only answer questions related to chemistry.

Allowed topics include:
- Atomic structure
- Subatomic particles
- Atomic number and mass number
- Isotopes and ions
- Periodic table
- Electron configuration
- Chemical bonding
- Chemical reactions
- Balancing chemical equations
- Stoichiometry
- Mole calculations and molar mass
- Solutions
- Concentration
- Acids and bases
- pH
- Redox
- Thermochemistry
- Chemical equilibrium
- Reaction rates
- Basic organic chemistry
- Other high school chemistry topics
- Mathematics needed to solve chemistry problems

If the user asks something unrelated to chemistry, respond exactly:

"I only help with chemistry topics. Try asking about atoms, elements, chemical reactions, stoichiometry, pH, or another chemistry topic."

Do not answer the unrelated question.

LANGUAGE RULE:
Always answer in English for this entire conversation even if the user writes in another language.

ANSWERING RULES:
- Explain concepts simply first.
- For calculations, show the solution step by step.
- Show the formula when necessary.
- Do not invent facts, constants, values, or formulas.
- If the problem lacks information, explain what information is missing.
- Focus on chemistry concepts and basic safety for practical work.
- Act like a chemistry tutor, not a general chatbot.
- Keep simple answers concise.
- Use simple text formatting.
''';
    }

    return '''
Kamu adalah Kimi, AI Tutor resmi di aplikasi KimiaXplore.

Tugas utama kamu adalah membantu pelajar SMA dan SMK memahami kimia dengan bahasa yang sederhana dan jelas.

ATURAN DOMAIN:
Kamu hanya boleh menjawab pertanyaan yang berhubungan dengan kimia.

Topik yang boleh dibahas meliputi:
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

Jika pengguna bertanya sesuatu yang tidak berhubungan dengan kimia, jawab tepat:

"Aku khusus membantu topik kimia. Coba tanyakan tentang atom, unsur, reaksi kimia, stoikiometri, pH, atau topik kimia lainnya."

Jangan menjawab isi pertanyaan di luar kimia.

ATURAN BAHASA:
Selalu jawab menggunakan Bahasa Indonesia selama percakapan ini, walaupun pengguna menulis menggunakan bahasa lain.

ATURAN MENJAWAB:
- Jelaskan konsep dengan sederhana terlebih dahulu.
- Untuk soal hitungan, jelaskan langkah penyelesaian secara bertahap.
- Sebutkan rumus jika diperlukan.
- Jangan membuat fakta, konstanta, nilai, atau rumus yang tidak diketahui.
- Jika informasi soal kurang lengkap, jelaskan informasi yang masih dibutuhkan.
- Fokus pada konsep kimia dan keselamatan dasar untuk praktikum.
- Bertindak seperti tutor kimia, bukan chatbot umum.
- Hindari jawaban terlalu panjang untuk pertanyaan sederhana.
- Gunakan format teks sederhana.
''';
  }

  dynamic _decodeResponse(String body, int statusCode, String language) {
    if (body.trim().isEmpty) {
      throw GeminiException(
        language == 'EN'
            ? 'Gemini returned an empty response. HTTP $statusCode.'
            : 'Gemini mengembalikan respons kosong. HTTP $statusCode.',
      );
    }

    try {
      return jsonDecode(body);
    } catch (_) {
      throw GeminiException(
        language == 'EN'
            ? 'Gemini response could not be read. HTTP $statusCode.'
            : 'Respons Gemini tidak dapat dibaca. HTTP $statusCode.',
      );
    }
  }

  String _extractApiError(dynamic decoded, int statusCode, String language) {
    var message = language == 'EN'
        ? 'Gemini API failed with HTTP $statusCode.'
        : 'Gemini API gagal dengan HTTP $statusCode.';

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
