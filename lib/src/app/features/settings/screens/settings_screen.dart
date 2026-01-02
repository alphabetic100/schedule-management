import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/bloc/auth_bloc.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(SignOutRequested());
            context.go(RouteName.auth);
          },
          icon: Icon(Icons.logout),
        ),
      ),
    );
  }
}
