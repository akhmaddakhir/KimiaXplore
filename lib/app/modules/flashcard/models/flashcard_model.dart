class FlashcardModel {
  final String id;
  final String question;
  final String answer;
  final String? hint;
  final String? category;

  const FlashcardModel({
    required this.id,
    required this.question,
    required this.answer,
    this.hint,
    this.category,
  });

  factory FlashcardModel.fromJson(Map<String, dynamic> json) {
    return FlashcardModel(
      id: json['id']?.toString() ?? '',
      question: json['front']?.toString() ?? json['question']?.toString() ?? '',
      answer: json['back']?.toString() ?? json['answer']?.toString() ?? '',
      hint: json['hint']?.toString(),
      category: json['category']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'front': question,
      'back': answer,
      'hint': hint,
      'category': category,
    };
  }
}
