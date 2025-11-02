class SavedPolicy {
  final String id;
  final String title;
  final String category;
  final DateTime deadline;
  final String status; // '신청마감', '신청시작', '자료제출마감', '설명회참석' 등
  final bool isToday;

  SavedPolicy({
    required this.id,
    required this.title,
    required this.category,
    required this.deadline,
    required this.status,
    this.isToday = false,
  });

  factory SavedPolicy.fromJson(Map<String, dynamic> json) {
    return SavedPolicy(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      deadline: DateTime.parse(json['deadline']),
      status: json['status'] ?? '',
      isToday: json['isToday'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'deadline': deadline.toIso8601String(),
      'status': status,
      'isToday': isToday,
    };
  }

  String get formattedDate {
    return '${deadline.day}일';
  }

  String get weekday {
    const weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[deadline.weekday - 1];
  }
}
