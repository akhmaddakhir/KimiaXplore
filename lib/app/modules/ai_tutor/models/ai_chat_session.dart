import 'ai_chat_message.dart';

class AiChatSession {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<AiChatMessage> messages;

  AiChatSession({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
  });

  String get lastMessageSnippet {
    if (messages.isEmpty) return '';
    final last = messages.last;
    final clean = last.text.replaceAll('\n', ' ').trim();
    if (clean.length > 60) {
      return '${clean.substring(0, 57)}...';
    }
    return clean;
  }

  int get messageCount => messages.length;

  String formatRelativeTime({String language = 'ID'}) {
    final now = DateTime.now();
    final difference = now.difference(updatedAt);

    final isSameDay = now.year == updatedAt.year &&
        now.month == updatedAt.month &&
        now.day == updatedAt.day;

    final hourStr = updatedAt.hour.toString().padLeft(2, '0');
    final minuteStr = updatedAt.minute.toString().padLeft(2, '0');
    final timeStr = '$hourStr:$minuteStr';

    if (isSameDay) {
      return language == 'EN' ? 'Today, $timeStr' : 'Hari ini, $timeStr';
    }

    final yesterday = now.subtract(const Duration(days: 1));
    final isYesterday = yesterday.year == updatedAt.year &&
        yesterday.month == updatedAt.month &&
        yesterday.day == updatedAt.day;

    if (isYesterday) {
      return language == 'EN' ? 'Yesterday, $timeStr' : 'Kemarin, $timeStr';
    }

    if (difference.inDays < 7) {
      final days = difference.inDays;
      return language == 'EN'
          ? '$days days ago'
          : '$days hari lalu';
    }

    const monthNamesID = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    const monthNamesEN = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final monthName = language == 'EN'
        ? monthNamesEN[updatedAt.month - 1]
        : monthNamesID[updatedAt.month - 1];

    return '${updatedAt.day} $monthName ${updatedAt.year}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'messages': messages.map((m) => m.toJson()).toList(),
    };
  }

  factory AiChatSession.fromJson(Map<String, dynamic> json) {
    return AiChatSession(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'Percakapan',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
      messages: (json['messages'] as List<dynamic>? ?? [])
          .map((m) => AiChatMessage.fromJson(m as Map<String, dynamic>))
          .toList(),
    );
  }

  AiChatSession copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<AiChatMessage>? messages,
  }) {
    return AiChatSession(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages,
    );
  }
}

