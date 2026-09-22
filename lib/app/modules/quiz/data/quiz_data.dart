import '../models/quiz_question_model.dart';

abstract final class QuizData {
  static const Map<String, List<QuizQuestionModel>> questionsByTopic = {
    'atomic_structure': [
      QuizQuestionModel(
        id: 'atomic_structure_q1',
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
        explanation:
            'Percobaan hamburan partikel alfa Rutherford menunjukkan bahwa sebagian besar partikel alfa dapat melewati lempeng emas tanpa dibelokkan. Hal ini menunjukkan bahwa sebagian besar volume atom merupakan ruang kosong. Atom juga memiliki inti yang sangat kecil, padat, dan bermuatan positif.',
      ),
      QuizQuestionModel(
        id: 'atomic_structure_q2',
        question: 'Partikel subatom yang memiliki muatan negatif adalah ...',
        options: ['Proton', 'Neutron', 'Elektron', 'Inti atom', 'Nukleon'],
        correctOptionIndex: 2,
        explanation:
            'Elektron merupakan partikel subatom yang bermuatan negatif. Proton memiliki muatan positif, sedangkan neutron tidak memiliki muatan listrik. Proton dan neutron berada di dalam inti atom, sementara elektron berada di daerah sekitar inti atom.',
      ),
      QuizQuestionModel(
        id: 'atomic_structure_q3',
        question:
            'Suatu atom memiliki 11 proton, 12 neutron, dan 11 elektron. Berapakah nomor massa atom tersebut?',
        options: ['11', '12', '22', '23', '34'],
        correctOptionIndex: 3,
        explanation:
            'Nomor massa merupakan jumlah proton dan neutron yang terdapat di dalam inti atom. Atom tersebut memiliki 11 proton dan 12 neutron, sehingga nomor massanya adalah 11 + 12 = 23. Elektron tidak dihitung dalam menentukan nomor massa.',
      ),
    ],

    'periodic_table': [
      QuizQuestionModel(
        id: 'periodic_table_q1',
        question:
            'Natrium (Na) memiliki konfigurasi elektron 2, 8, 1. Berdasarkan konfigurasi tersebut, natrium berada pada golongan berapa?',
        options: [
          'Golongan 1',
          'Golongan 2',
          'Golongan 13',
          'Golongan 17',
          'Golongan 18',
        ],
        correctOptionIndex: 0,
        explanation:
            'Natrium memiliki satu elektron pada kulit terluarnya. Dalam sistem periodik, unsur golongan utama dengan satu elektron valensi berada pada golongan 1 atau IA. Natrium termasuk golongan logam alkali.',
      ),
      QuizQuestionModel(
        id: 'periodic_table_q2',
        question:
            'Dalam tabel periodik, unsur-unsur yang berada pada golongan yang sama umumnya memiliki kesamaan dalam hal ...',
        options: [
          'Jumlah kulit elektron',
          'Nomor atom',
          'Jumlah neutron',
          'Jumlah elektron valensi',
          'Nomor massa',
        ],
        correctOptionIndex: 3,
        explanation:
            'Unsur-unsur dalam golongan utama yang sama memiliki jumlah elektron valensi yang sama. Kesamaan elektron valensi menyebabkan unsur-unsur tersebut memiliki sifat kimia yang mirip. Contohnya, litium, natrium, dan kalium sama-sama memiliki satu elektron valensi.',
      ),
      QuizQuestionModel(
        id: 'periodic_table_q3',
        question:
            'Apa yang ditunjukkan oleh nomor periode suatu unsur dalam tabel periodik?',
        options: [
          'Jumlah proton di dalam inti atom',
          'Jumlah kulit elektron yang terisi',
          'Jumlah neutron di dalam inti atom',
          'Jumlah elektron valensi',
          'Jumlah seluruh partikel subatom',
        ],
        correctOptionIndex: 1,
        explanation:
            'Nomor periode menunjukkan jumlah kulit elektron yang terisi pada atom dalam keadaan dasar. Contohnya, magnesium memiliki konfigurasi elektron 2, 8, 2. Karena elektronnya menempati tiga kulit, magnesium berada pada periode 3.',
      ),
    ],

    'chemical_bonding': [
      QuizQuestionModel(
        id: 'chemical_bonding_q1',
        question: 'Kenapa sih suatu ikatan kovalen bisa disebut polar?',
        options: [
          'Karena elektronnya pindah sepenuhnya ke atom lain',
          'Karena ada perbedaan keelektronegatifan antar atom',
          'Karena ikatan ini cuma bisa terjadi pada logam',
          'Karena momen dipolnya selalu nol',
          'Karena jumlah elektronnya harus sama',
        ],
        correctOptionIndex: 1,
        explanation:
            'Ikatan kovalen polar terbentuk ketika dua atom yang berikatan memiliki perbedaan keelektronegatifan. Akibatnya, pasangan elektron ikatan lebih tertarik ke salah satu atom sehingga terjadi distribusi muatan yang tidak merata.',
      ),
      QuizQuestionModel(
        id: 'chemical_bonding_q2',
        question:
            'Ikatan yang terbentuk antara ion natrium (Na⁺) dan ion klorida (Cl⁻) pada senyawa NaCl disebut ...',
        options: [
          'Ikatan kovalen nonpolar',
          'Ikatan kovalen polar',
          'Ikatan logam',
          'Ikatan ion',
          'Ikatan hidrogen',
        ],
        correctOptionIndex: 3,
        explanation:
            'NaCl terbentuk melalui ikatan ion antara ion Na⁺ yang bermuatan positif dan ion Cl⁻ yang bermuatan negatif. Kedua ion tersebut saling tarik-menarik karena memiliki muatan listrik yang berlawanan.',
      ),
      QuizQuestionModel(
        id: 'chemical_bonding_q3',
        question:
            'Apa yang terjadi ketika dua atom hidrogen membentuk molekul H₂?',
        options: [
          'Kedua atom saling berbagi pasangan elektron',
          'Salah satu atom menyerahkan seluruh elektronnya',
          'Kedua atom berubah menjadi ion positif',
          'Kedua inti atom bergabung menjadi satu',
          'Salah satu atom berubah menjadi neutron',
        ],
        correctOptionIndex: 0,
        explanation:
            'Dua atom hidrogen membentuk molekul H₂ dengan menggunakan satu pasangan elektron secara bersama-sama. Ikatan tersebut disebut ikatan kovalen tunggal. Karena kedua atom memiliki keelektronegatifan yang sama, ikatan H₂ bersifat kovalen nonpolar.',
      ),
    ],
  };

  static List<QuizQuestionModel> getQuestionsByTopic(String topicId) {
    return questionsByTopic[topicId] ?? [];
  }
}
