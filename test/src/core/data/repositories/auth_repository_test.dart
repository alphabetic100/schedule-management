import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:schedule_management/src/core/data/repositories/auth_repository.dart';
import 'package:schedule_management/src/core/service/firebase_service.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseService extends Mock implements FirebaseService {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFirebaseService mockFirebaseService;
  late AuthRepository authRepository;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseService = MockFirebaseService();

    authRepository = AuthRepository(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
      firebaseService: mockFirebaseService,
    );
  });

  group('AuthRepository', () {
    test('idTokenStream emits token when user is signed in', () async {
      final mockUser = MockUser();
      const token = 'test_token';

      // Arrange
      when(() => mockUser.getIdToken()).thenAnswer((_) async => token);
      when(
        () => mockFirebaseAuth.idTokenChanges(),
      ).thenAnswer((_) => Stream.value(mockUser));

      // Act
      final stream = authRepository.idTokenStream;

      // Assert
      expect(stream, emits(token));
    });

    test('idTokenStream emits null when user is signed out', () async {
      // Arrange
      when(
        () => mockFirebaseAuth.idTokenChanges(),
      ).thenAnswer((_) => Stream.value(null));

      // Act
      final stream = authRepository.idTokenStream;

      // Assert
      expect(stream, emits(null));
    });
  });
}
