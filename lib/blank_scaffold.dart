import 'package:flutter/material.dart';
import 'package:particles_fly/particles_fly.dart';

class BlankScaffold extends StatelessWidget {
  final FloatingActionButton? floatingActionButton;
  final List<Widget> children;
  const BlankScaffold({
    super.key,
    required this.children,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: ParticlesFly(
              height: size.height,
              width: size.width,
              connectDots: true,
              numberOfParticles: 50,
              lineColor: Colors.white54,
              particleColor: Colors.white54,
            ),
          ),
          ...children,
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
