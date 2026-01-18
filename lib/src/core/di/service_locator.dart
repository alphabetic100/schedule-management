import 'package:get_it/get_it.dart';
import 'package:schedule_management/src/core/data/repositories/auth_repository.dart';
import 'package:schedule_management/src/core/data/repositories/schedule_repository.dart';
import 'package:schedule_management/src/core/service/firebase_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<FirebaseService>(() => FirebaseService());

  // Repositories
  final authRepository = AuthRepository(firebaseService: sl<FirebaseService>());
  await authRepository.initialize();
  sl.registerLazySingleton<AuthRepository>(() => authRepository);
  sl.registerLazySingleton<ScheduleRepository>(() => ScheduleRepositoryImpl());
}
