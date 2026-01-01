import 'package:flutter/material.dart';

class LetterByLetterText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Duration delay;

  const LetterByLetterText({
    super.key,
    required this.text,
    required this.style,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 400);
    final totalDuration = delay + animationDuration;

    return Wrap(
      children: List.generate(text.length, (index) {
        final delayRatio =
            totalDuration.inMilliseconds == 0
                ? 0.0
                : delay.inMilliseconds / totalDuration.inMilliseconds;
        final animationRatio = 1.0 - delayRatio;

        final charStart = delayRatio + (index / text.length) * animationRatio;

        return TweenAnimationBuilder<double>(
          duration: totalDuration,
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Interval(
            charStart.clamp(0.0, 1.0),
            1.0,
            curve: Curves.easeOut,
          ),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(10 * (1 - value), 0),
                child: Text(text[index], style: style),
              ),
            );
          },
        );
      }),
    );
  }
}
