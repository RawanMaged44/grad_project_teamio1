class TaskModel {
  TaskModel({
    this.success,
    this.data,
    this.errors,
    this.statusCode,
  });

  TaskModel.fromJson(dynamic json) {
    success = json['success'];
    errors = json['errors'];
    statusCode = json['statusCode'];

    // Personal tasks API returns data as a List directly
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = (json['data'] as List)
            .map((v) => Tasks.fromJson(v))
            .toList();
      }
    }
  }

  bool? success;
  List<Tasks>? data;
  dynamic errors;
  int? statusCode;
}

class Tasks {
  Tasks({
    this.id,
    this.title,
    this.description,
    this.deadline,
    this.status,
    this.createdAt,
  });

  Tasks.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  String? id;
  String? title;
  String? description;
  String? deadline;
  int? status;
  String? createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'deadline': deadline,
        'status': status,
        'createdAt': createdAt,
      };
}

/// Request model for creating a personal task
class CreateTaskRequest {
  final String title;
  final String description;
  final String deadline;
  final int status;

  CreateTaskRequest({
    required this.title,
    required this.description,
    required this.deadline,
    this.status = 0,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'deadline': deadline,
        'status': status,
      };
}
