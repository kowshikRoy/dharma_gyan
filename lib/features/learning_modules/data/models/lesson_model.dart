import 'package:flutter/material.dart'; // For Color, if used directly in model

enum LessonStatus {
  locked,
  unlocked, // Available to start
  inProgress,
  completed,
}

enum LessonType {
  chant,
  story,
  textAnalysis,
  quiz,
  // Add more types as needed
}

class LessonModel {
  final String id;
  final String unitId; // To associate with a LearningUnitModel
  final String title;
  final LessonStatus status;
  final LessonType type;
  final int orderInUnit; // To define its position on the path within a unit
  // final String? iconAsset; // Optional: for a specific icon on the lesson node

  LessonModel({
    required this.id,
    required this.unitId,
    required this.title,
    required this.status,
    required this.type,
    required this.orderInUnit,
    // this.iconAsset,
  });

  // Helper to get color based on status, can be moved to a view model or widget
  Color getStatusColor() {
    switch (status) {
      case LessonStatus.completed:
        return Colors.green; // Or a theme color
      case LessonStatus.inProgress:
        return Colors.blue; // Or a theme color
      case LessonStatus.unlocked:
        return Colors.orangeAccent; // Or a theme color
      case LessonStatus.locked:
        return Colors.grey.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}
