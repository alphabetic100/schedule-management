import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:schedule_management/firebase_options.dart';
import 'package:schedule_management/src/app/app.dart';
import 'package:schedule_management/src/core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await di.init();

  runApp(const SchedulerApp());
}
