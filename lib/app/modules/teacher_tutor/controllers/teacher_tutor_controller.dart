import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/teacher_lesson_model.dart';

class TeacherTutorController extends GetxController {
  static const List<String> categories = [
    'Semua',
    'Struktur Atom',
    'Ikatan Kimia',
    'Stoikiometri',
  ];

  final selectedCategory = 'Semua'.obs;
  final searchQuery = ''.obs;
  final watchedIds = <String>{'atom_aufbau'}.obs;
  final remindedLiveIds = <String>{}.obs;
  final showLastWatchedBanner = true.obs;
  final lastWatchedLessonId = 'atom_aufbau'.obs;

  final TeacherLiveClass upcomingLiveClass = const TeacherLiveClass(
    id: 'live_stoikiometri_1',
    title: 'Bedah Soal Stoikiometri UTBK',
    scheduleLabel: 'Jumat, 19:00 WIB',
    teacherName: 'Bu Ratna, M.Pd',
    teacherAvatar: 'assets/images/profile_avatar_teacher.svg',
    durationLabel: '45 menit',
  );

  final List<TeacherChapterModule> modules = const [
    TeacherChapterModule(
      id: 'mod_atom',
      babLabel: 'BAB 1',
      title: 'Struktur Atom & Orbital',
      teacherName: 'Bu Ratna, M.Pd',
      icon: Icons.blur_circular_rounded,
      lessons: [
        TeacherLessonModel(
          id: 'atom_aufbau',
          title: 'Kenapa Elektron Isi 4s Dulu Baru 3d?',
          teacherName: 'Bu Ratna, M.Pd',
          teacherRole: 'Pengajar Kimia',
          teacherAvatar: 'assets/images/profile_avatar_teacher.svg',
          category: 'Struktur Atom',
          duration: '07:45',
          durationSeconds: 465,
          summaryPoints: [
            'Urutan pengisian elektron mengikuti nilai (n + l) dari yang paling kecil.',
            'Orbital 4s memiliki n + l = 4, sedangkan 3d memiliki n + l = 5.',
            'Saat membentuk kation (misal Fe²⁺), elektron dilepas dari kulit terluar (4s) terlebih dahulu.',
          ],
          formulaHighlight: '4s (n+l = 4) diisi sebelum 3d (n+l = 5)',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Pengantar tingkat energi', seconds: 0),
            TeacherVideoChapter(timestamp: '02:10', title: 'Aturan (n + l) Aufbau', seconds: 130),
            TeacherVideoChapter(timestamp: '04:45', title: 'Konfigurasi ion logam transisi', seconds: 285),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Orbital manakah yang memiliki energi lebih rendah menurut aturan (n + l)?',
            options: ['3d', '4s', '4p', '5s'],
            correctIndex: 1,
            explanation: '4s memiliki n + l = 4 + 0 = 4, lebih rendah daripada 3d (5), 4p (5), dan 5s (5).',
          ),
        ),
        TeacherLessonModel(
          id: 'atom_bilangan_kuantum',
          title: 'Menentukan 4 Bilangan Kuantum dengan Cepat',
          teacherName: 'Bu Ratna, M.Pd',
          teacherRole: 'Pengajar Kimia',
          teacherAvatar: 'assets/images/profile_avatar_teacher.svg',
          category: 'Struktur Atom',
          duration: '06:30',
          durationSeconds: 390,
          summaryPoints: [
            'n menunjukkan kulit utama, l menunjukkan subkulit (s=0, p=1, d=2, f=3).',
            'm bernilai dari -l hingga +l sesuai kotak orbital terakhir.',
            's bernilai +1/2 (panah ke atas) atau -1/2 (panah ke bawah).',
          ],
          formulaHighlight: 'Subkulit: s=0, p=1, d=2, f=3 | m ∈ [-l .. +l]',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Arti n, l, m, dan s', seconds: 0),
            TeacherVideoChapter(timestamp: '02:40', title: 'Menggambar diagram orbital', seconds: 160),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Jika elektron terakhir berada di subkulit 3p, berapakah nilai bilangan kuantum l?',
            options: ['0', '1', '2', '3'],
            correctIndex: 1,
            explanation: 'Subkulit p memiliki nilai bilangan kuantum azimut l = 1.',
          ),
        ),
        TeacherLessonModel(
          id: 'atom_soal_utbk',
          title: 'Pembahasan Soal: Ion Fe³⁺ & Bilangan Kuantum',
          teacherName: 'Bu Ratna, M.Pd',
          teacherRole: 'Pengajar Kimia',
          teacherAvatar: 'assets/images/profile_avatar_teacher.svg',
          category: 'Struktur Atom',
          duration: '05:15',
          durationSeconds: 315,
          isPracticeVideo: true,
          difficultyLabel: 'UTBK',
          summaryPoints: [
            'Tulis konfigurasi atom netral Fe (Z = 26) terlebih dahulu: [Ar] 4s² 3d⁶.',
            'Untuk menjadi Fe³⁺, lepas 2 elektron dari 4s lalu 1 elektron dari 3d.',
            'Hasil akhir Fe³⁺ adalah [Ar] 3d⁵ dengan 5 elektron tak berpasangan.',
          ],
          formulaHighlight: '₂₆Fe: [Ar] 4s² 3d⁶  →  ₂₆Fe³⁺: [Ar] 3d⁵',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Membaca soal & jebakan umum', seconds: 0),
            TeacherVideoChapter(timestamp: '02:15', title: 'Langkah eliminasi jawaban', seconds: 135),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Berapa jumlah elektron tidak berpasangan pada ion Fe³⁺ (Z = 26)?',
            options: ['2', '3', '4', '5'],
            correctIndex: 3,
            explanation: 'Konfigurasi Fe³⁺ berakhir di 3d⁵ sehingga kelima orbital d masing-masing terisi 1 elektron.',
          ),
        ),
      ],
    ),
    TeacherChapterModule(
      id: 'mod_ikatan',
      babLabel: 'BAB 2',
      title: 'Ikatan Kimia & Bentuk Molekul',
      teacherName: 'Pak Dimas, S.Si',
      icon: Icons.hub_rounded,
      lessons: [
        TeacherLessonModel(
          id: 'ikatan_ion_kovalen',
          title: 'Membedakan Ikatan Ion, Kovalen, dan Logam',
          teacherName: 'Pak Dimas, S.Si',
          teacherRole: 'Mentor Kimia',
          teacherAvatar: 'assets/images/profile_avatar_scientist.svg',
          category: 'Ikatan Kimia',
          duration: '06:20',
          durationSeconds: 380,
          summaryPoints: [
            'Ikatan ion terjadi antara logam dan nonlogam melalui serah-terima elektron.',
            'Ikatan kovalen terjadi antar nonlogam melalui pemakaian bersama pasangan elektron.',
            'Perhatikan pengecualian klasik seperti BeCl₂ yang berikatan kovalen.',
          ],
          formulaHighlight: 'Ion: Logam + Nonlogam | Kovalen: Nonlogam + Nonlogam',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Cara cepat lihat golongan unsur', seconds: 0),
            TeacherVideoChapter(timestamp: '03:10', title: 'Contoh & pengecualian soal', seconds: 190),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Senyawa manakah yang memiliki ikatan kovalen?',
            options: ['NaCl', 'KBr', 'CO₂', 'MgO'],
            correctIndex: 2,
            explanation: 'CO₂ terbentuk dari karbon (C) dan oksigen (O) yang sama-sama nonlogam.',
          ),
        ),
        TeacherLessonModel(
          id: 'ikatan_soal_vsepr',
          title: 'Pembahasan Soal: Bentuk Molekul & Kepolaran',
          teacherName: 'Pak Dimas, S.Si',
          teacherRole: 'Mentor Kimia',
          teacherAvatar: 'assets/images/profile_avatar_scientist.svg',
          category: 'Ikatan Kimia',
          duration: '05:40',
          durationSeconds: 340,
          isPracticeVideo: true,
          difficultyLabel: 'Menengah',
          summaryPoints: [
            'Hitung PEI (Pasangan Elektron Ikatan) dan PEB (Pasangan Elektron Bebas) atom pusat.',
            'Molekul simetris tanpa PEB di atom pusat umumnya bersifat nonpolar.',
          ],
          formulaHighlight: 'PEB = (Elektron Valensi Pusat - Ikatan) / 2',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Menghitung PEI & PEB', seconds: 0),
            TeacherVideoChapter(timestamp: '02:50', title: 'Menentukan kepolaran NH₃ vs BF₃', seconds: 170),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Apakah bentuk molekul NH₃ yang memiliki 3 PEI dan 1 PEB?',
            options: ['Linear', 'Trigonal planar', 'Piramida trigonal', 'Tetrahedral'],
            correctIndex: 2,
            explanation: 'Tipe AX₃E (3 PEI, 1 PEB) menghasilkan bentuk piramida trigonal.',
          ),
        ),
      ],
    ),
    TeacherChapterModule(
      id: 'mod_stoikiometri',
      babLabel: 'BAB 3',
      title: 'Stoikiometri & Pereaksi Pembatas',
      teacherName: 'Kak Bima, S.T',
      icon: Icons.balance_rounded,
      lessons: [
        TeacherLessonModel(
          id: 'stoik_mol',
          title: 'Jembatan Mol: Konversi Massa, Partikel & Gas',
          teacherName: 'Kak Bima, S.T',
          teacherRole: 'Tutor Saintek',
          teacherAvatar: 'assets/images/profile_avatar_man.svg',
          category: 'Stoikiometri',
          duration: '08:15',
          durationSeconds: 495,
          summaryPoints: [
            'Jadikan mol (n) sebagai pusat konversi semua besaran kimia.',
            'Pada kondisi STP (0°C, 1 atm), 1 mol gas menempati 22,4 liter.',
          ],
          formulaHighlight: 'n = massa / Mr  |  n = V(STP) / 22,4',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Bagan jembatan mol', seconds: 0),
            TeacherVideoChapter(timestamp: '04:00', title: 'Contoh hitungan campuran', seconds: 240),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Berapa mol gas O₂ dengan volume 11,2 liter pada keadaan STP?',
            options: ['0,25 mol', '0,5 mol', '1,0 mol', '2,0 mol'],
            correctIndex: 1,
            explanation: 'n = 11,2 / 22,4 = 0,5 mol.',
          ),
        ),
        TeacherLessonModel(
          id: 'stoik_soal_pembatas',
          title: 'Pembahasan Soal: Pereaksi Pembatas 30 Detik',
          teacherName: 'Kak Bima, S.T',
          teacherRole: 'Tutor Saintek',
          teacherAvatar: 'assets/images/profile_avatar_man.svg',
          category: 'Stoikiometri',
          duration: '05:50',
          durationSeconds: 350,
          isPracticeVideo: true,
          difficultyLabel: 'UTBK',
          summaryPoints: [
            'Setarakan persamaan reaksi terlebih dahulu.',
            'Bagi mol mula-mula dengan koefisien masing-masing; hasil terkecil adalah pereaksi pembatas.',
          ],
          formulaHighlight: 'Pereaksi Pembatas = min(mol awal / koefisien)',
          chapters: [
            TeacherVideoChapter(timestamp: '00:00', title: 'Trik bagi koefisien', seconds: 0),
            TeacherVideoChapter(timestamp: '02:45', title: 'Menghitung sisa zat', seconds: 165),
          ],
          miniQuiz: TeacherMiniQuiz(
            question: 'Pada 2H₂ + O₂ → 2H₂O dengan 4 mol H₂ dan 3 mol O₂, mana pereaksi pembatasnya?',
            options: ['H₂', 'O₂', 'Keduanya habis', 'Tidak dapat ditentukan'],
            correctIndex: 0,
            explanation: 'H₂: 4/2 = 2 lebih kecil dari O₂: 3/1 = 3, sehingga H₂ habis lebih dulu.',
          ),
        ),
      ],
    ),
  ];

  List<TeacherLessonModel> get allLessons =>
      modules.expand((m) => m.lessons).toList();

  List<TeacherLessonModel> get recommendedLessons {
    final q = searchQuery.value.trim().toLowerCase();
    final list = allLessons.where((l) => !l.isPracticeVideo).toList();
    if (q.isEmpty) return list;
    return list
        .where(
          (l) =>
              l.title.toLowerCase().contains(q) ||
              l.category.toLowerCase().contains(q) ||
              l.teacherName.toLowerCase().contains(q),
        )
        .toList();
  }

  List<TeacherChapterModule> get filteredModules {
    final q = searchQuery.value.trim().toLowerCase();
    final cat = selectedCategory.value;
    return modules.where((m) {
      final matchesCat =
          cat == 'Semua' || m.lessons.any((l) => l.category == cat);
      if (!matchesCat) return false;
      if (q.isEmpty) return true;
      return m.title.toLowerCase().contains(q) ||
          m.babLabel.toLowerCase().contains(q) ||
          m.lessons.any((l) => l.title.toLowerCase().contains(q));
    }).toList();
  }

  TeacherLessonModel get lastWatchedLesson {
    return allLessons.firstWhere(
      (l) => l.id == lastWatchedLessonId.value,
      orElse: () => allLessons.first,
    );
  }

  int get totalLessonCount =>
      modules.fold(0, (sum, m) => sum + m.lessons.length);

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  bool isWatched(String lessonId) => watchedIds.contains(lessonId);

  void markAsWatched(String lessonId) {
    watchedIds.add(lessonId);
    lastWatchedLessonId.value = lessonId;
    showLastWatchedBanner.value = true;
  }

  void dismissLastWatchedBanner() {
    showLastWatchedBanner.value = false;
  }

  bool isLiveReminded(String liveId) => remindedLiveIds.contains(liveId);

  void toggleLiveReminder(String liveId) {
    if (remindedLiveIds.contains(liveId)) {
      remindedLiveIds.remove(liveId);
    } else {
      remindedLiveIds.add(liveId);
    }
  }
}
