class Todo {
  final String uid;
  final String title;
  final String? description;
  bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.uid,
    required this.title,
    this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'completed': completed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
