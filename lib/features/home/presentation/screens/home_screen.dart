import 'package:flutter/material.dart';
import 'package:dharma_gyan/features/learning_modules/data/models/learning_unit_model.dart';
import 'package:dharma_gyan/features/learning_modules/data/models/lesson_model.dart';
import 'package:dharma_gyan/features/home/presentation/widgets/learning_unit_widget.dart';
import 'package:dharma_gyan/features/home/presentation/widgets/lesson_node_widget.dart';
import 'package:dharma_gyan/features/home/presentation/widgets/path_painter.dart'; // Import PathPainter

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Sample Data
  late List<LearningUnitModel>
  _learningUnits; // Now a list of LearningUnitModel

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Simulating fetching data
    _learningUnits = [
      LearningUnitModel(
        id: 'unit1',
        title: 'Ramayana - The Beginning',
        status: LearningUnitStatus.completed,
        lessons: [
          LessonModel(
            id: 'l1u1',
            unitId: 'unit1',
            title: 'Intro to Ramayana',
            status: LessonStatus.completed,
            type: LessonType.story,
            orderInUnit: 1,
          ),
          LessonModel(
            id: 'l2u1',
            unitId: 'unit1',
            title: 'Dasharatha\'s Sons',
            status: LessonStatus.completed,
            type: LessonType.story,
            orderInUnit: 2,
          ),
        ],
      ),
      LearningUnitModel(
        id: 'unit2',
        title: 'Hanuman Chalisa - Part 1',
        status: LearningUnitStatus.current,
        lessons: [
          LessonModel(
            id: 'l1u2',
            unitId: 'unit2',
            title: 'Verse 1-5',
            status: LessonStatus.completed,
            type: LessonType.chant,
            orderInUnit: 1,
          ),
          LessonModel(
            id: 'l2u2',
            unitId: 'unit2',
            title: 'Verse 6-10',
            status: LessonStatus.inProgress,
            type: LessonType.chant,
            orderInUnit: 2,
          ),
          LessonModel(
            id: 'l3u2',
            unitId: 'unit2',
            title: 'Quiz 1',
            status: LessonStatus.unlocked,
            type: LessonType.quiz,
            orderInUnit: 3,
          ),
        ],
      ),
      LearningUnitModel(
        id: 'unit3',
        title: 'Mahabharata - Core Teachings',
        status: LearningUnitStatus.locked,
        lessons: [
          LessonModel(
            id: 'l1u3',
            unitId: 'unit3',
            title: 'Introduction',
            status: LessonStatus.locked,
            type: LessonType.textAnalysis,
            orderInUnit: 1,
          ),
          LessonModel(
            id: 'l2u3',
            unitId: 'unit3',
            title: 'The Great War',
            status: LessonStatus.locked,
            type: LessonType.story,
            orderInUnit: 2,
          ),
          LessonModel(
            // Adding more locked lessons for unit3 for visual
            id: 'l3u3',
            unitId: 'unit3',
            title: 'Key Characters',
            status: LessonStatus.locked,
            type: LessonType.story,
            orderInUnit: 3,
          ),
          LessonModel(
            id: 'l4u3',
            unitId: 'unit3',
            title: 'Final Quiz',
            status: LessonStatus.locked,
            type: LessonType.quiz,
            orderInUnit: 4,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const int streakCount = 10;
    const int currencyCount = 500;
    const int livesCount = 3;
    final Color iconColor =
        Theme.of(context).appBarTheme.foregroundColor ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: iconColor), // Diya
              const SizedBox(width: 4),
              Text(
                '$streakCount',
                style: TextStyle(
                  color: iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.spa_outlined, color: iconColor), // Lotus Gem
            const SizedBox(width: 4),
            Text(
              '$currencyCount',
              style: TextStyle(
                color: iconColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border, color: iconColor), // Heart
                const SizedBox(width: 4),
                Text(
                  '$livesCount',
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        // Use LayoutBuilder to get constraints for PathPainter
        builder: (context, constraints) {
          const double mandalaHeight = 100.0;
          const double lessonNodeHeight = 40.0;
          const double verticalSpacingBetweenUnitAndLessons = 20.0;
          // This constant was previously used but not directly in the new logic for Y offset.
          // const double verticalSpacingBetweenLessonGroups = 20.0;
          const double verticalSpacingBetweenUnits = 50.0;

          double estimatedBlockHeight =
              mandalaHeight +
              lessonNodeHeight + // Approximate height for one row of lessons
              verticalSpacingBetweenUnitAndLessons +
              verticalSpacingBetweenUnits; // Space until the next unit's center

          List<Widget> stackChildren = [];

          double totalPathHeight = _learningUnits.length * estimatedBlockHeight;
          if (_learningUnits.isEmpty) totalPathHeight = constraints.maxHeight;

          stackChildren.add(
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: totalPathHeight,
              child: CustomPaint(
                painter: PathPainter(
                  itemCount: _learningUnits.length,
                  totalNodes: _learningUnits.length,
                  itemHeight: estimatedBlockHeight,
                  pathWidth: constraints.maxWidth,
                ),
                child: Container(),
              ),
            ),
          );

          for (int i = 0; i < _learningUnits.length; i++) {
            final unit = _learningUnits[i];

            Offset unitCenter = PathPainter.calculateNodeCenter(
              nodeIndex: i,
              totalNodes: _learningUnits.length,
              pathWidth: constraints.maxWidth,
              itemHeight: estimatedBlockHeight,
            );

            stackChildren.add(
              Positioned(
                top: unitCenter.dy - (mandalaHeight / 2),
                left: unitCenter.dx - (mandalaHeight / 2),
                child: LearningUnitWidget(
                  unit: unit,
                  onTap: () => print('Tapped Unit: ${unit.title}'),
                ),
              ),
            );

            double lessonsYOffset =
                unitCenter.dy +
                (mandalaHeight / 2) +
                verticalSpacingBetweenUnitAndLessons;

            if (unit.lessons.isNotEmpty) {
              double totalLessonsWidth =
                  (unit.lessons.length * lessonNodeHeight) +
                  ((unit.lessons.length - 1) * 15.0); // 15.0 is spacing
              double lessonRowStartX =
                  (constraints.maxWidth - totalLessonsWidth) / 2;
              // Clamp to ensure it doesn't go off-screen if too many lessons
              lessonRowStartX = lessonRowStartX.clamp(
                0.0,
                constraints.maxWidth - totalLessonsWidth,
              );

              for (int j = 0; j < unit.lessons.length; j++) {
                final lesson = unit.lessons[j];

                stackChildren.add(
                  Positioned(
                    top: lessonsYOffset,
                    left: lessonRowStartX + j * (lessonNodeHeight + 15.0),
                    child: LessonNodeWidget(
                      lesson: lesson,
                      onTap: () => print('Tapped Lesson: ${lesson.title}'),
                    ),
                  ),
                );
              }
            }
          }

          return SingleChildScrollView(
            child: SizedBox(
              height: totalPathHeight + 100,
              child: Stack(children: stackChildren),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action for practice
        },
        label: const Text('Practice'),
        icon: const Icon(Icons.menu_book_outlined),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
