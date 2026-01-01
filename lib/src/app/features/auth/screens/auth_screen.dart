import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/bloc/auth_bloc.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/constants/icon_paths.dart';
import 'package:schedule_management/src/core/utils/constants/image_paths.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

part '../widgets/social_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteName.home);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(child: Image.asset(ImagePath.onBoarding)),
                ),
                Text(
                  'Welcome to\nSchedule Manager',
                  textAlign: TextAlign.left,
                  style: context.displayLarge.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Manage your time efficiently and never miss an important task.',
                  style: context.bodyMedium.copyWith(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                const SizedBox(height: 25),
                _SocialButton(
                  onTap: () => context.read<AuthBloc>().add(SignInWithGoogle()),
                  label: 'Continue with Google',
                  icon: IconPath.googleIcon,
                  color: const Color(0xFF2E7D32),
                  isLoading:
                      state is AuthLoading && state.method == AuthMethod.google,
                ),
                const SizedBox(height: 16),
                _SocialButton(
                  onTap:
                      () => context.read<AuthBloc>().add(SignInWithFacebook()),
                  label: 'Continue with Facebook',
                  icon: IconPath.facebookIcon,
                  color: const Color(0xFF145DBF),
                  isLoading:
                      state is AuthLoading &&
                      state.method == AuthMethod.facebook,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
