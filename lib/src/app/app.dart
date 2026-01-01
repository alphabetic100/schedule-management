import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_management/src/app/features/auth/bloc/auth_bloc.dart';
import 'package:schedule_management/src/app/routes/app_routes.dart';
import 'package:schedule_management/src/core/utils/theme/app_theme.dart';

class SchedulerApp extends StatelessWidget {
  const SchedulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
      child: MaterialApp.router(
        title: 'Schedule Management App',
        routerConfig: AppRoutes.router,
        theme: AppTheme.appTheme,
      ),
    );
  }
}
