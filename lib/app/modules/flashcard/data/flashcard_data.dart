import '../models/flashcard_model.dart';

abstract final class FlashcardData {
  static const Map<String, List<FlashcardModel>> flashcardsByTopic = {
    'atomic_structure': [
      FlashcardModel(
        id: 'atomic_structure_f1',
        question: 'Apa yang dimaksud dengan atom?',
        answer:
            'Atom adalah unit terkecil dari suatu unsur yang masih memiliki sifat kimia unsur tersebut.',
      ),
      FlashcardModel(
        id: 'atomic_structure_f2',
        question: 'Apa saja tiga partikel utama penyusun atom?',
        answer:
            'Atom tersusun atas proton yang bermuatan positif, neutron yang tidak bermuatan, dan elektron yang bermuatan negatif.',
      ),
      FlashcardModel(
        id: 'atomic_structure_f3',
        question: 'Apa yang dimaksud dengan nomor atom?',
        answer:
            'Nomor atom adalah jumlah proton dalam inti atom. Pada atom netral, jumlah proton sama dengan jumlah elektron.',
      ),
      FlashcardModel(
        id: 'atomic_structure_f4',
        question: 'Apa perbedaan nomor atom dan nomor massa?',
        answer:
            'Nomor atom menunjukkan jumlah proton, sedangkan nomor massa menunjukkan jumlah proton dan neutron dalam inti atom.',
      ),
      FlashcardModel(
        id: 'atomic_structure_f5',
        question: 'Apa yang dimaksud dengan isotop?',
        answer:
            'Isotop adalah atom-atom dari unsur yang sama dengan jumlah proton sama, tetapi jumlah neutron berbeda.',
      ),
    ],

    'periodic_table': [
      FlashcardModel(
        id: 'periodic_table_f1',
        question: 'Apa yang dimaksud dengan tabel periodik unsur?',
        answer:
            'Tabel periodik adalah susunan unsur-unsur kimia berdasarkan kenaikan nomor atom dan kemiripan sifat kimianya.',
      ),
      FlashcardModel(
        id: 'periodic_table_f2',
        question: 'Apa yang dimaksud dengan golongan dalam tabel periodik?',
        answer:
            'Golongan adalah kolom vertikal dalam tabel periodik. Unsur-unsur dalam satu golongan umumnya memiliki kemiripan sifat kimia.',
      ),
      FlashcardModel(
        id: 'periodic_table_f3',
        question: 'Apa yang dimaksud dengan periode dalam tabel periodik?',
        answer:
            'Periode adalah baris horizontal dalam tabel periodik. Tabel periodik modern memiliki tujuh periode.',
      ),
      FlashcardModel(
        id: 'periodic_table_f4',
        question: 'Apa yang dimaksud dengan elektron valensi?',
        answer:
            'Elektron valensi adalah elektron pada kulit terluar atom yang berperan penting dalam pembentukan ikatan kimia.',
      ),
      FlashcardModel(
        id: 'periodic_table_f5',
        question: 'Apa yang dimaksud dengan unsur gas mulia?',
        answer:
            'Gas mulia adalah unsur-unsur golongan 18 yang memiliki kulit valensi penuh dan umumnya sangat sukar bereaksi. Contohnya helium, neon, dan argon.',
      ),
    ],

    'chemical_bonding': [
      FlashcardModel(
        id: 'chemical_bonding_f1',
        question: 'Apa yang dimaksud dengan ikatan kimia?',
        answer:
            'Ikatan kimia adalah interaksi yang menyebabkan atom-atom atau ion-ion bergabung membentuk struktur kimia yang lebih stabil.',
      ),
      FlashcardModel(
        id: 'chemical_bonding_f2',
        question: 'Apa yang dimaksud dengan ikatan ion?',
        answer:
            'Ikatan ion adalah ikatan yang terbentuk akibat gaya tarik elektrostatik antara ion bermuatan positif dan ion bermuatan negatif.',
      ),
      FlashcardModel(
        id: 'chemical_bonding_f3',
        question: 'Apa yang dimaksud dengan ikatan kovalen?',
        answer:
            'Ikatan kovalen adalah ikatan kimia yang terbentuk ketika dua atom menggunakan satu atau lebih pasangan elektron secara bersama-sama.',
      ),
      FlashcardModel(
        id: 'chemical_bonding_f4',
        question: 'Apa perbedaan ikatan kovalen polar dan nonpolar?',
        answer:
            'Ikatan kovalen polar memiliki distribusi elektron yang tidak merata karena perbedaan keelektronegatifan. Pada ikatan kovalen nonpolar, pasangan elektron digunakan secara relatif merata.',
      ),
      FlashcardModel(
        id: 'chemical_bonding_f5',
        question: 'Apa yang dimaksud dengan ikatan logam?',
        answer:
            'Ikatan logam adalah ikatan yang terjadi akibat gaya tarik antara ion-ion positif logam dan elektron-elektron yang terdelokalisasi dalam struktur logam.',
      ),
    ],
  };

  static List<FlashcardModel> getFlashcardsByTopic(String topicId) {
    return flashcardsByTopic[topicId] ?? [];
  }
}
