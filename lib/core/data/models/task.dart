import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final String dueDate;
  final TaskStatus status;

  const Task({
    this.id,
    required this.title,
    this.description,
    required this.dueDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'status': status.index,
    };
  }

  /// Convert Map to Task object (for reading from database)
  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['due_date'],
      status: TaskStatus.values[map['status']],
    );
  }

  @override
  List<Object?> get props => [id, title, description, dueDate, status];
}

enum TaskStatus { pending, inProgress, completed }

extension TaskStatusExtension on TaskStatus {
  String get displayName {
    switch (this) {
      case TaskStatus.pending:
        return "Pending";
      case TaskStatus.inProgress:
        return "In Progress";
      case TaskStatus.completed:
        return "Completed";
    }
  }
}
