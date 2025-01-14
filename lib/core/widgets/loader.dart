import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class Loader extends StatefulWidget {
  final double size;
  final Color? color;

  const Loader({
    super.key,
    this.size = 45.0,
    this.color,
  });

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: widget.size,
      width: widget.size,
      child: CustomPaint(
        painter: _IOSIndicatorPainter(
          progress: _controller,
          color: widget.color ?? AppColors.blackPrimary,
        ),
      ),
    ));
  }
}

class _IOSIndicatorPainter extends CustomPainter {
  final Animation<double> progress;
  final Color color;

  _IOSIndicatorPainter({
    required this.progress,
    required this.color,
  }) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 5.0;
    final double radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Define arc parameters
    const double fullCircle = 2 * 3.141592653589793;
    const double visibleSweep =
        fullCircle * 0.8; // Arc length (80% of the circle)
    final double startAngle = progress.value * fullCircle; // Rotating start

    // Draw the arc with fading effect
    for (double i = 0; i < visibleSweep; i += 0.1) {
      // Reverse opacity calculation
      final double opacity = (i / visibleSweep).clamp(0.0, 1.0);
      paint.color = color.withOpacity(opacity);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + i, // Faded side follows the rotation
        0.1, // Small step for smooth fade
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
