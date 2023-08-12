class Todo {
  final String title;
  final String? description;
  bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  Todo({
    required this.title,
    this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });
}
