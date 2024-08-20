import 'package:flutter/material.dart';
import 'path_optimization.dart';

class MapView extends StatelessWidget {
  final List<Node> path;
  final String mapAssetPath = 'assets/images/store_layout.png'; // The path to your map image

  MapView(this.path, List<Map<String, dynamic>> productList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shortest Path'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Background map image
            Positioned.fill(
              child: Image.asset(
                mapAssetPath,
                fit: BoxFit.contain,
              ),
            ),
            // Path overlay
            CustomPaint(
              painter: PathPainter(path),
              size: Size.infinite,
            ),
          ],
        ),
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final List<Node> path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    if (path.isNotEmpty) {
      for (int i = 0; i < path.length - 1; i++) {
        final start = Offset(
          path[i].position.dx * size.width,
          path[i].position.dy * size.height,
        );
        final end = Offset(
          path[i + 1].position.dx * size.width,
          path[i + 1].position.dy * size.height,
        );
        canvas.drawLine(start, end, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
