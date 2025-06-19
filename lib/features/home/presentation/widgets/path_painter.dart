import 'package:flutter/material.dart';
import 'dart:math'; // Import for sin function

class PathPainter extends CustomPainter {
  final int
  itemCount; // Number of items (units + groups of lessons) to draw path for
  final double
  itemHeight; // Approximate height of each item (mandala or row of lessons)
  final double pathWidth; // Width of the canvas
  final int totalNodes; // Total number of nodes (units) the path connects

  PathPainter({
    required this.itemCount, // This is effectively totalNodes for drawing segments
    required this.totalNodes,
    required this.itemHeight,
    required this.pathWidth,
  });

  // Static method to calculate the center of a node
  static Offset calculateNodeCenter({
    required int nodeIndex, // 0 to totalNodes - 1
    required int totalNodes,
    required double pathWidth,
    required double itemHeight, // Height of one block (unit + lessons)
    double initialYOffsetRatio =
        0.5, // Ratio of itemHeight for the first node's Y center
  }) {
    double y = (nodeIndex + initialYOffsetRatio) * itemHeight;

    // X calculation (sine wave)
    double amplitude = pathWidth / 4.5; // Slightly less amplitude
    // Make roughly 1.5 to 2 sine waves over the typical viewable number of items (e.g. 5-6 items)
    // This factor determines how many full sine waves appear over 'totalNodes'.
    // A factor of 1.0 means one full sine wave.
    double waveCycles = 1.5;
    // Normalize nodeIndex to be from 0 to 1, then scale by waveCycles * 2PI
    double angle =
        (nodeIndex / totalNodes.toDouble()) * waveCycles * 2 * 3.1415926535;

    double x = (pathWidth / 2) + amplitude * sin(angle); // Using sin directly

    x = x.clamp(
      pathWidth * 0.15,
      pathWidth * 0.85,
    ); // Clamp to prevent going too close to edges
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors
          .grey
          .shade400 // Slightly darker path
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          5.0 // Slightly thicker path
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (totalNodes == 0) return;

    Offset startPoint = calculateNodeCenter(
      nodeIndex: 0,
      totalNodes: totalNodes,
      pathWidth: pathWidth,
      itemHeight: itemHeight,
    );
    path.moveTo(startPoint.dx, startPoint.dy);

    for (int i = 0; i < totalNodes - 1; i++) {
      // Iterate up to totalNodes - 1 to draw segments between nodes
      Offset currentNodeCenter = calculateNodeCenter(
        nodeIndex: i,
        totalNodes: totalNodes,
        pathWidth: pathWidth,
        itemHeight: itemHeight,
      );
      Offset nextNodeCenter = calculateNodeCenter(
        nodeIndex: i + 1,
        totalNodes: totalNodes,
        pathWidth: pathWidth,
        itemHeight: itemHeight,
      );

      // Control points for cubic Bezier curve
      // These points help create a smoother, more organic curve
      double controlX1 = currentNodeCenter.dx;
      double controlY1 =
          currentNodeCenter.dy +
          itemHeight * 0.4; // Control point below current
      double controlX2 = nextNodeCenter.dx;
      double controlY2 =
          nextNodeCenter.dy - itemHeight * 0.4; // Control point above next

      path.cubicTo(
        controlX1,
        controlY1,
        controlX2,
        controlY2,
        nextNodeCenter.dx,
        nextNodeCenter.dy,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) {
    return oldDelegate.itemCount != itemCount ||
        oldDelegate.itemHeight != itemHeight ||
        oldDelegate.pathWidth != pathWidth;
  }
}
