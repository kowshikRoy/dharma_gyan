import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/learning_modules/data/models/learning_unit_model.dart';

class LearningUnitWidget extends StatelessWidget {
  final LearningUnitModel unit;
  final VoidCallback? onTap;

  const LearningUnitWidget({super.key, required this.unit, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine glow effect for current unit
    BoxDecoration decoration;
    if (unit.status == LearningUnitStatus.current) {
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: unit.getStatusColor(),
        boxShadow: [
          BoxShadow(
            color: unit.getStatusColor().withOpacity(0.7),
            blurRadius: 15.0,
            spreadRadius: 5.0,
          ),
        ],
      );
    } else {
      decoration = BoxDecoration(
        shape: BoxShape.circle,
        color: unit.getStatusColor(),
      );
    }

    return InkWell(
      onTap: unit.status == LearningUnitStatus.locked ? null : onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 100, // Size of the Mandala
        height: 100,
        decoration: decoration,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              unit.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: unit.status == LearningUnitStatus.locked
                    ? Colors.white70
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
