import '../models/quiz_question_model.dart';

abstract final class QuizData {
  static const List<QuizQuestionModel> defaultQuestions = [
    QuizQuestionModel(
      id: 'q1',
      question: 'Kenapa sih suatu ikatan kovalen bisa disebut polar?',
      options: [
        'Karena elektronnya pindah sepenuhnya ke atom lain',
        'Karena ada perbedaan keelektronegatifan antar atom',
        'Karena ikatan ini cuma bisa terjadi pada logam',
        'Karena momen dipolnya selalu nol',
        'Karena jumlah elektronnya harus sama',
      ],
      correctOptionIndex: 1,
      hint:
          'Coba ingat, pasangan elektron dalam ikatan polar nggak tertarik sama kuat ke kedua atom.',
      explanation:
          'Yap! Ikatan kovalen jadi polar karena ada perbedaan keelektronegatifan. Akibatnya, pasangan elektron lebih tertarik ke salah satu atom.',
    ),

    QuizQuestionModel(
      id: 'q2',
      question:
          'Dari percobaan Rutherford, kita bisa tahu hal penting apa tentang atom?',
      options: [
        'Atom berbentuk seperti model roti kismis Thomson',
        'Sebagian besar ruang di dalam atom ternyata kosong',
        'Elektron bergerak pada lintasan dengan energi tertentu',
        'Neutron berada di dalam inti atom',
        'Atom tidak memiliki inti',
      ],
      correctOptionIndex: 1,
      hint:
          'Sebagian besar partikel alfa bisa lewat begitu saja tanpa dibelokkan. Kira-kira kenapa?',
      explanation:
          'Benar! Karena sebagian besar partikel alfa bisa menembus lempeng emas tanpa berubah arah, Rutherford menyimpulkan bahwa sebagian besar volume atom adalah ruang kosong.',
    ),

    QuizQuestionModel(
      id: 'q3',
      question:
          'Natrium (Na) punya konfigurasi elektron 2, 8, 1. Biar lebih stabil, apa yang paling mungkin dilakukan Na?',
      options: [
        'Menangkap 1 elektron dan jadi Na⁻',
        'Melepaskan 1 elektron dan jadi Na⁺',
        'Berbagi 7 elektron dengan atom lain',
        'Melepaskan semua elektronnya',
        'Nggak perlu melakukan apa-apa',
      ],
      correctOptionIndex: 1,
      hint:
          'Na punya 1 elektron di kulit terluarnya. Mana yang lebih simpel: nambah 7 atau lepas 1?',
      explanation:
          'Betul! Natrium lebih mudah melepaskan 1 elektron valensi dan membentuk Na⁺. Setelah itu, konfigurasi elektronnya menjadi 2, 8 yang lebih stabil.',
    ),
  ];
}
