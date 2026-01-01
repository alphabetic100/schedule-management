import 'package:get_it/get_it.dart';
import 'package:schedule_management/src/core/data/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repositories
  final authRepository = AuthRepository();
  await authRepository.initialize();
  sl.registerLazySingleton<AuthRepository>(() => authRepository);
}
