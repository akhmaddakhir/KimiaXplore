enum TopicActivityType {
  materi,
  flashcard,
  kuis,
  simulasi;

  String get title {
    switch (this) {
      case TopicActivityType.materi:
        return 'Materi';
      case TopicActivityType.flashcard:
        return 'Flashcard';
      case TopicActivityType.kuis:
        return 'Kuis';
      case TopicActivityType.simulasi:
        return 'Simulasi';
    }
  }

  String get subtitle {
    switch (this) {
      case TopicActivityType.materi:
        return 'Pelajari teori dan konsep kimia';
      case TopicActivityType.flashcard:
        return 'Hafalkan istilah dan rumus penting';
      case TopicActivityType.kuis:
        return 'Uji pemahaman dan latihan soal';
      case TopicActivityType.simulasi:
        return 'Eksperimen virtual interaktif';
    }
  }
}
