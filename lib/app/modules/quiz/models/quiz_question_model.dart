class QuizQuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;

  const QuizQuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'];
    final List<String> optionsList = (rawOptions is List)
        ? rawOptions.map((e) => e.toString()).toList()
        : <String>[];

    return QuizQuestionModel(
      id: json['id']?.toString() ?? '',
      question: json['question']?.toString() ?? '',
      options: optionsList,
      correctOptionIndex: json['correct_option_index'] as int? ?? 0,
      explanation: json['explanation']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correct_option_index': correctOptionIndex,
      'explanation': explanation,
    };
  }
}
