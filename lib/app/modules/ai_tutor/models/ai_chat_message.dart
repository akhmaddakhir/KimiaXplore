class AiChatMessage {
  final String text;
  final bool isUser;

  const AiChatMessage({required this.text, required this.isUser});

  Map<String, dynamic> toGeminiContent() {
    return {
      'role': isUser ? 'user' : 'model',
      'parts': [
        {'text': text},
      ],
    };
  }
}
