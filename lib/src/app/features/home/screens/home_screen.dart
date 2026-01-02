import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/bloc/auth_bloc.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';
import 'package:schedule_management/src/core/extensions/app_size.dart';
import 'package:schedule_management/src/core/extensions/text_style.dart';
import 'package:schedule_management/src/core/utils/helpers/app_helpers.dart';
import 'package:schedule_management/src/core/utils/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String userName = 'User';
        String? photoUrl;

        if (state is Authenticated) {
          userName = state.user.name ?? 'User';
          photoUrl = state.user.photoUrl;
        }

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: context.height * 0.08,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.secondaryColor,
                  radius: 25,
                  backgroundImage:
                      photoUrl != null ? NetworkImage(photoUrl) : null,
                  child:
                      photoUrl == null
                          ? const Icon(Icons.person, color: Colors.white)
                          : null,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, $userName!',
                      style: context.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppHelpers.getFormattedToday(),
                      style: context.bodyMedium.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  context.go(RouteName.settings);
                },
              ),
            ],
          ),
          body: const Center(child: Text('Welcome to Schedule Management')),
        );
      },
    );
  }
}
