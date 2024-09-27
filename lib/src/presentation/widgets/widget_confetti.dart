import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class WidgetConfetti extends StatefulWidget {
  const WidgetConfetti({Key? key}) : super(key: key);


  @override
  State<WidgetConfetti> createState() => _WidgetConfettiState();
}

class _WidgetConfettiState extends State<WidgetConfetti> {
  late ConfettiController controller;

  @override
  void initState() {
    controller = ConfettiController(duration: const Duration(seconds: 1));
    controller.play();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    final random = Random();
    final path = Path();
    final shapeType = random.nextInt(2);

    switch (shapeType) {
      case 0:
        final rectWidth = size.width * 0.2;
        final rectHeight = size.height;
        final startX = (size.width - rectWidth) / 2;
        final startY = (size.height - rectHeight) / 2;
        path.moveTo(startX, startY);
        path.lineTo(startX + rectWidth, startY);
        path.lineTo(startX + rectWidth, startY + rectHeight);
        path.lineTo(startX, startY + rectHeight);
        path.close();
        break;
      case 1:
        final triWidth = size.width * 0.7;
        final triHeight = size.height * 0.7;
        final triStartX = (size.width - triWidth) / 2;
        final triStartY = (size.height - triHeight) / 2;
        path.moveTo(triStartX + triWidth / 2, triStartY);
        path.lineTo(triStartX + triWidth, triStartY + triHeight);
        path.lineTo(triStartX, triStartY + triHeight);
        path.close();
        break;
    }

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
          confettiController: controller,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: false,
          blastDirection: pi / 2,
          maxBlastForce: 20,
          minBlastForce: 5,
          emissionFrequency: 0.02,
          numberOfParticles: 80,
          gravity: 0.3,
          colors: const [
            Colors.red,
            Colors.lightGreenAccent,
            Colors.tealAccent,
            Colors.pink,
            Colors.orange,
            Colors.deepPurple,
          ],
          createParticlePath: drawStar),
    );
  }
}
