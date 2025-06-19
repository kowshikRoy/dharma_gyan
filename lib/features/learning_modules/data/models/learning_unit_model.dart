import 'package:flutter/material.dart'; // For Color, if used directly in model
import 'package:dharma_gyan/features/learning_modules/data/models/lesson_model.dart'; // Import LessonModel

enum LearningUnitStatus { locked, current, completed }

class LearningUnitModel {
  final String id;
  final String title;
  final String description; // Optional
  final LearningUnitStatus status;
  final List<LessonModel> lessons; // List of lessons in this unit
  // final String? iconAsset; // Optional: for a specific icon on the Mandala

  LearningUnitModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.status,
    required this.lessons,
    // this.iconAsset,
  });

  int get lessonsInUnit => lessons.length;
  int get lessonsCompleted =>
      lessons.where((lesson) => lesson.status == LessonStatus.completed).length;

  // Helper to get color based on status, can be moved to a view model or widget
  Color getStatusColor() {
    switch (status) {
      case LearningUnitStatus.completed:
        return Colors.amber; // Gold
      case LearningUnitStatus.current:
        return Colors.deepOrangeAccent; // Saffron
      case LearningUnitStatus.locked:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
