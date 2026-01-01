import 'package:flutter/material.dart';
import 'package:schedule_management/src/app/features/splash/widgets/letter_by_letter_text.dart';
import 'package:schedule_management/src/app/features/splash/widgets/shimmer_text.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LetterByLetterText(
                    text: 'Schedule',
                    style: context.displayLarge.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  LetterByLetterText(
                    text: ' Manager',
                    delay: const Duration(milliseconds: 400),
                    style: context.displayLarge.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                curve: const Interval(0.8, 1.0),
                builder: (context, opacity, child) {
                  return Opacity(opacity: opacity, child: child);
                },
                child: ShimmerText(
                  child: Text('At your fingertips', style: context.labelMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
