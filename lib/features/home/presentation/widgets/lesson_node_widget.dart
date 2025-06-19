import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/learning_modules/data/models/lesson_model.dart';

class LessonNodeWidget extends StatelessWidget {
  final LessonModel lesson;
  final VoidCallback? onTap;

  const LessonNodeWidget({super.key, required this.lesson, this.onTap});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    switch (lesson.status) {
      case LessonStatus.completed:
        iconData = Icons.check_circle;
        break;
      case LessonStatus.inProgress:
        iconData = Icons.play_circle_fill; // Or a custom 'current lesson' icon
        break;
      case LessonStatus.unlocked:
        iconData = Icons.circle_outlined; // Or a specific icon for 'startable'
        break;
      case LessonStatus.locked:
      default:
        iconData = Icons.lock_outline;
        break;
    }

    return InkWell(
      onTap: lesson.status == LessonStatus.locked ? null : onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40, // Size of the lesson node
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: lesson.getStatusColor(),
          border: Border.all(
            color: lesson.status == LessonStatus.locked
                ? Colors.grey.shade600
                : Colors.white,
            width: 2,
          ),
        ),
        child: Icon(
          iconData,
          color: lesson.status == LessonStatus.locked
              ? Colors.grey.shade700
              : Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
