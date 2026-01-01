import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/bloc/auth_bloc.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
              context.go(RouteName.auth);
            },
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to Schedule Management')),
    );
  }
}
