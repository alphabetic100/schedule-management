import 'package:flutter/material.dart';

class ShimmerText extends StatelessWidget {
  final Widget child;

  const ShimmerText({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -1.0, end: 2.0),
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey.shade400,
                Colors.black,
                Colors.grey.shade400,
              ],
              stops: [value - 0.3, value, value + 0.3],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}
