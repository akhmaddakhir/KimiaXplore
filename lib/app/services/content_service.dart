import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../modules/flashcard/data/flashcard_data.dart';
import '../modules/flashcard/models/flashcard_model.dart';
import '../modules/home/data/home_topics.dart';
import '../modules/home/models/topic_model.dart';
import '../modules/lab/data/lab_simulations.dart';
import '../modules/lab/models/simulation_model.dart';
import '../modules/material/data/material_data.dart';
import '../modules/material/data/material_lesson_data.dart';
import '../modules/material/models/material_lesson_model.dart';
import '../modules/material/models/material_model.dart';
import '../modules/quiz/data/quiz_data.dart';
import '../modules/quiz/models/quiz_question_model.dart';
import '../modules/shop/models/pricing_package_model.dart';

class ContentService {
  final SupabaseClient _client = Supabase.instance.client;

  String _normalizeTopicSlug(String topicId) {
    if (topicId == 'TPC000001') return 'atomic_structure';
    if (topicId == 'TPC000002') return 'chemical_bonding';
    if (topicId == 'TPC000003') return 'stoichiometry';
    if (topicId == 'TPC000004') return 'thermodynamics';
    if (topicId == 'TPC000005') return 'reaction_rate';
    if (topicId == 'TPC000006') return 'acid_base';
    return topicId;
  }

  // ---------------------------------------------------------------------------
  // 1. TOPICS (Daftar Topik Pembelajaran Supabase + Fallback HomeTopics)
  // ---------------------------------------------------------------------------
  Future<List<TopicModel>> getTopics() async {
    try {
      final response = await _client
          .from('topics')
          .select()
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final items = data.map((item) {
          final map = item as Map<String, dynamic>;
          final slug = map['slug']?.toString() ?? map['topic_code']?.toString() ?? '';
          final rawLessons = (map['total_materials'] as num?)?.toInt() ?? 1;
          final total = rawLessons > 0 ? rawLessons : 1;
          final diff = map['difficulty']?.toString().toLowerCase();
          final level = (diff == 'lanjut') ? 'Lanjut' : ((diff == 'menengah') ? 'Menengah' : 'Dasar');

          return TopicModel(
            id: slug,
            title: map['title']?.toString() ?? '',
            description: map['description']?.toString() ?? '',
            level: level,
            totalLessons: total,
            completedLessons: 0,
          );
        }).toList();

        debugPrint('[ContentService] Berhasil memuat ${items.length} topik riil dari Supabase');
        return items;
      }
    } catch (e) {
      debugPrint('[ContentService] Error getTopics: $e');
    }

    return HomeTopics.items;
  }

  // ---------------------------------------------------------------------------
  // 2. MATERIALS (Materi Pembelajaran Supabase + Fallback MaterialData)
  // ---------------------------------------------------------------------------
  Future<MaterialModel?> getMaterial(String topicId) async {
    try {
      final isCode = topicId.startsWith('TPC');
      final response = await _client
          .from('materials')
          .select('*, topics!inner(slug, topic_code)')
          .eq(isCode ? 'topic_code' : 'topics.slug', topicId)
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final sections = <MaterialSection>[];

        for (final row in data) {
          final content = row['content'] ?? row['sections'];
          if (content is List) {
            for (final s in content) {
              if (s is Map<String, dynamic>) {
                final rawParas = s['paragraphs'];
                List<String> paragraphs;
                if (rawParas is List) {
                  paragraphs = rawParas.map((p) => p.toString()).toList();
                } else if (s['text'] != null) {
                  paragraphs = [s['text'].toString()];
                } else {
                  paragraphs = [];
                }
                sections.add(
                  MaterialSection(
                    title: s['title']?.toString() ??
                        row['title']?.toString() ??
                        'Materi',
                    paragraphs: paragraphs,
                  ),
                );
              }
            }
          }
        }

        if (sections.isNotEmpty) {
          debugPrint(
              '[ContentService] Berhasil memuat ${sections.length} seksi materi dari Supabase untuk $topicId');
          return MaterialModel(topicId: topicId, sections: sections);
        }
      }
    } catch (e) {
      debugPrint('[ContentService] Error getMaterial ($topicId): $e');
    }

    // Fallback kurasi lokal agar pengguna selalu mendapatkan materi berkualitas
    final slug = _normalizeTopicSlug(topicId);
    final fallbackMaterial = MaterialData.findByTopicId(slug) ??
        MaterialData.findByTopicId('atomic_structure');
    if (fallbackMaterial != null) {
      debugPrint('[ContentService] Menggunakan data fallback materi untuk $topicId ($slug)');
      return MaterialModel(
        topicId: topicId,
        sections: fallbackMaterial.sections,
      );
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // 3. LESSONS (Sub-modul Materi Supabase + Fallback MaterialLessonData)
  // ---------------------------------------------------------------------------
  Future<List<MaterialLessonModel>> getLessonsByTopic(String topicId) async {
    try {
      final isCode = topicId.startsWith('TPC');
      final response = await _client
          .from('materials')
          .select('*, topics!inner(slug, topic_code)')
          .eq(isCode ? 'topic_code' : 'topics.slug', topicId)
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        int sectionOffset = 0;
        final lessons = <MaterialLessonModel>[];

        for (final row in data) {
          final content = row['content'] ?? row['sections'];
          final sectionCount =
              (content is List && content.isNotEmpty) ? content.length : 1;

          final indexes = List.generate(
            sectionCount,
            (index) => sectionOffset + index,
          );
          sectionOffset += sectionCount;

          lessons.add(
            MaterialLessonModel(
              id: row['id']?.toString() ?? '${topicId}_${lessons.length}',
              topicId: topicId,
              title: row['title']?.toString() ?? 'Materi',
              description: row['subtitle']?.toString() ??
                  row['description']?.toString() ??
                  '',
              sectionIndexes: indexes,
            ),
          );
        }

        if (lessons.isNotEmpty) {
          debugPrint(
              '[ContentService] Berhasil memuat ${lessons.length} sub-modul materi dari Supabase untuk $topicId');
          return lessons;
        }
      }
    } catch (e) {
      debugPrint('[ContentService] Error getLessonsByTopic ($topicId): $e');
    }

    // Fallback kurasi lokal sub-modul materi
    final slug = _normalizeTopicSlug(topicId);
    final fallbackLessons = MaterialLessonData.getLessonsByTopic(slug);
    if (fallbackLessons.isNotEmpty) {
      debugPrint('[ContentService] Menggunakan data fallback sub-modul untuk $topicId ($slug)');
      return fallbackLessons.map((l) => MaterialLessonModel(
        id: l.id,
        topicId: topicId,
        title: l.title,
        description: l.description,
        sectionIndexes: l.sectionIndexes,
      )).toList();
    }

    return [
      MaterialLessonModel(
        id: '${topicId}_default',
        topicId: topicId,
        title: 'Materi Pembelajaran',
        description: 'Pelajari konsep utama topik ini.',
        sectionIndexes: const [0],
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // 4. QUIZZES (Bank Soal Kuis Supabase + Fallback QuizData)
  // ---------------------------------------------------------------------------
  Future<List<QuizQuestionModel>> getQuizzesByTopic(String topicId) async {
    try {
      final isCode = topicId.startsWith('TPC');
      final response = await _client
          .from('quizzes')
          .select(
              '*, topics!inner(slug, topic_code), quiz_questions(*, quiz_answers(*))')
          .eq(isCode ? 'topic_code' : 'topics.slug', topicId)
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final List<QuizQuestionModel> questions = [];

        for (final quiz in data) {
          final rawQuestions = quiz['quiz_questions'] as List<dynamic>?;
          if (rawQuestions != null) {
            rawQuestions.sort((a, b) =>
                ((a['display_order'] as num?) ?? 0)
                    .compareTo((b['display_order'] as num?) ?? 0));

            for (final q in rawQuestions) {
              final rawAnswers = (q['quiz_answers'] as List<dynamic>?) ?? [];
              rawAnswers.sort((a, b) =>
                  ((a['display_order'] as num?) ?? 0)
                      .compareTo((b['display_order'] as num?) ?? 0));

              final options = rawAnswers
                  .map((a) => a['answer_text']?.toString() ?? '')
                  .toList();
              final correctIdx =
                  rawAnswers.indexWhere((a) => a['is_correct'] == true);

              questions.add(
                QuizQuestionModel(
                  id: q['id']?.toString() ?? '',
                  question: q['question_text']?.toString() ?? '',
                  options: options.isNotEmpty ? options : ['A', 'B', 'C', 'D'],
                  correctOptionIndex: correctIdx != -1 ? correctIdx : 0,
                  explanation: q['explanation']?.toString() ?? '',
                ),
              );
            }
          }
        }

        if (questions.isNotEmpty) {
          debugPrint(
              '[ContentService] Berhasil memuat ${questions.length} kuis dari Supabase untuk topik: $topicId');
          return questions;
        }
      }
    } catch (e) {
      debugPrint('[ContentService] Error getQuizzesByTopic ($topicId): $e');
    }

    // Fallback kurasi lokal soal kuis interaktif
    final slug = _normalizeTopicSlug(topicId);
    final fallbackQuestions = QuizData.getQuestionsByTopic(slug);
    if (fallbackQuestions.isNotEmpty) {
      debugPrint('[ContentService] Menggunakan data fallback kuis untuk $topicId ($slug)');
      return fallbackQuestions;
    }

    return QuizData.getQuestionsByTopic('atomic_structure');
  }

  // ---------------------------------------------------------------------------
  // 5. FLASHCARDS (Kartu Hafalan Supabase + Fallback FlashcardData)
  // ---------------------------------------------------------------------------
  Future<List<FlashcardModel>> getFlashcardsByTopic(String topicId) async {
    try {
      final isCode = topicId.startsWith('TPC');
      final response = await _client
          .from('flashcards')
          .select('*, topics!inner(slug, topic_code), flashcard_items(*)')
          .eq(isCode ? 'topic_code' : 'topics.slug', topicId)
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final List<FlashcardModel> cards = [];

        for (final set in data) {
          final rawItems = set['flashcard_items'] as List<dynamic>?;
          if (rawItems != null) {
            rawItems.sort((a, b) =>
                ((a['display_order'] as num?) ?? 0)
                    .compareTo((b['display_order'] as num?) ?? 0));

            for (final item in rawItems) {
              cards.add(
                FlashcardModel(
                  id: item['id']?.toString() ?? '',
                  question: item['front_text']?.toString() ?? '',
                  answer: item['back_text']?.toString() ?? '',
                  hint: item['hint']?.toString() ?? '',
                  category: set['title']?.toString() ?? 'Umum',
                ),
              );
            }
          }
        }

        if (cards.isNotEmpty) {
          debugPrint(
              '[ContentService] Berhasil memuat ${cards.length} flashcard dari Supabase untuk topik: $topicId');
          return cards;
        }
      }
    } catch (e) {
      debugPrint('[ContentService] Error getFlashcardsByTopic ($topicId): $e');
    }

    // Fallback kurasi lokal kartu hafalan
    final slug = _normalizeTopicSlug(topicId);
    final fallbackCards = FlashcardData.getFlashcardsByTopic(slug);
    if (fallbackCards.isNotEmpty) {
      debugPrint('[ContentService] Menggunakan data fallback flashcard untuk $topicId ($slug)');
      return fallbackCards;
    }

    return FlashcardData.getFlashcardsByTopic('atomic_structure');
  }

  // ---------------------------------------------------------------------------
  // 6. SIMULATIONS (Status Lab Virtual Terhubung Supabase + Engine Lokal)
  // ---------------------------------------------------------------------------
  Future<List<SimulationModel>> getSimulations() async {
    try {
      final response = await _client
          .from('simulations')
          .select('*, topics(slug)')
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final items = data.map((item) {
          final map = item as Map<String, dynamic>;
          final id = map['id']?.toString() ?? '';
          final title = map['title']?.toString() ?? '';
          final isAvail = map['status'] == 'aktif';
          final diff = map['difficulty']?.toString().toLowerCase();
          final level = (diff == 'lanjut') ? 'Lanjut' : ((diff == 'menengah') ? 'Menengah' : 'Dasar');

          final localMatch = LabSimulations.items
              .where((local) => local.title.toLowerCase().contains(title.toLowerCase().split(' ').first))
              .firstOrNull;

          return SimulationModel(
            id: localMatch?.id ?? id,
            title: title,
            description: map['description']?.toString() ?? '',
            imageAsset: localMatch?.imageAsset,
            isAvailable: isAvail,
            category: map['category']?.toString() ?? 'Interaktif',
            level: level,
          );
        }).toList();

        debugPrint(
            '[ContentService] Berhasil memuat ${items.length} simulasi dari Supabase');
        return items;
      }
    } catch (e) {
      debugPrint('[ContentService] Error getSimulations: $e');
    }

    // Engine simulasi lab interaktif lokal (sesuai kebutuhan kode canvas & widget simulasi)
    return LabSimulations.items;
  }

  // ---------------------------------------------------------------------------
  // 7. PACKAGES (Paket Berlangganan Toko Murni dari Database Supabase)
  // ---------------------------------------------------------------------------
  Future<List<PricingPackageModel>> getPackages() async {
    try {
      final response = await _client
          .from('packages')
          .select()
          .order('display_order', ascending: true);

      final List<dynamic> data = response as List<dynamic>;

      if (data.isNotEmpty) {
        final items = data.map((item) {
          final map = item as Map<String, dynamic>;
          final rawPrice = (map['price'] as num?)?.toInt() ?? 0;
          final durationMonths = (map['duration_months'] as num?)?.toInt() ?? 1;
          final code = (map['package_code']?.toString() ?? '').toUpperCase();

          // Jika harga di database masih 0, berikan harga resmi default
          int priceNum = rawPrice;
          int? origNum = (map['original_price'] as num?)?.toInt();

          if (priceNum <= 0) {
            if (code == 'ATOM' || durationMonths == 1) {
              priceNum = 19000;
              origNum = origNum ?? 25000;
            } else if (code == 'CATALYST' || durationMonths == 3) {
              priceNum = 49000;
              origNum = origNum ?? 57000;
            } else if (code == 'QUANTUM' || durationMonths == 12) {
              priceNum = 149000;
              origNum = origNum ?? 228000;
            } else {
              priceNum = 29000;
            }
          }

          final priceStr = 'Rp${_formatNumber(priceNum)}';
          final origStr = (origNum != null && origNum > priceNum) ? 'Rp${_formatNumber(origNum)}' : null;
          final perMonth = durationMonths > 0 ? (priceNum / durationMonths).round() : priceNum;
          final perMonthStr = 'Rp${_formatNumber(perMonth)}/bln';

          final benefitsRaw = map['benefits'];
          final List<String> benefits = (benefitsRaw is List)
              ? benefitsRaw.map((b) => b.toString()).toList()
              : [];

          final name = map['name']?.toString() ?? 'Paket';
          final badge = map['badge']?.toString() ?? (code == 'CATALYST' ? 'Populer' : (code == 'QUANTUM' ? 'Hemat' : null));
          final isPopular = map['is_popular'] == true || code == 'CATALYST';

          return PricingPackageModel(
            id: map['package_code']?.toString().toLowerCase() ?? map['id']?.toString() ?? '',
            title: name,
            duration: '$durationMonths Bulan',
            price: priceStr,
            originalPrice: origStr,
            perMonthPrice: perMonthStr,
            badge: badge,
            isPopular: isPopular,
            features: benefits,
          );
        }).toList();

        debugPrint(
            '[ContentService] Berhasil memuat ${items.length} paket langganan dari Supabase');
        return items;
      }
    } catch (e) {
      debugPrint('[ContentService] Error getPackages: $e');
    }

    return const [
      PricingPackageModel(
        id: 'atom',
        title: 'Atom Starter',
        duration: '1 Bulan',
        price: 'Rp19.000',
        originalPrice: 'Rp25.000',
        perMonthPrice: 'Rp19.000/bln',
        isPopular: false,
        features: [
          'Akses seluruh materi & modul dasar',
          'Tutor Kimia AI Cerdas hingga 50 pesan/hari',
          'Belajar tanpa iklan',
        ],
      ),
      PricingPackageModel(
        id: 'catalyst',
        title: 'Catalyst Pass',
        duration: '3 Bulan',
        price: 'Rp49.000',
        originalPrice: 'Rp57.000',
        perMonthPrice: 'Rp16.333/bln',
        badge: 'Populer',
        isPopular: true,
        features: [
          'Akses seluruh modul & materi kimia',
          'Tutor Kimia AI Cerdas hingga 200 pesan/hari',
          'Simulasi lab kimia interaktif',
          'Belajar tanpa iklan',
          'Akses fitur baru lebih awal',
        ],
      ),
      PricingPackageModel(
        id: 'quantum',
        title: 'Quantum Pass',
        duration: '12 Bulan',
        price: 'Rp149.000',
        originalPrice: 'Rp228.000',
        perMonthPrice: 'Rp12.417/bln',
        badge: 'Hemat',
        isPopular: false,
        features: [
          'Akses tak terbatas seluruh kurikulum',
          'Tutor Kimia AI Cerdas tanpa batasan kuota',
          'Simulasi lab virtual interaktif',
          'Bank soal kuis lengkap & pembahasan',
          'Belajar tanpa iklan',
          'Akses fitur baru lebih awal',
        ],
      ),
    ];
  }

  static String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
