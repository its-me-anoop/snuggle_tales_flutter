// Importing required packages and modules
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snuggle_tales/app/app.dart';
import 'package:snuggle_tales/models/user_model.dart';
import 'package:snuggle_tales/repositories/repositories.dart';

// Mock class for AuthenticationRepository
class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

// Mock class for User
class MockUser extends Mock implements User {}

void main() {
  // Grouping tests under 'AppBloc'
  group('AppBloc', () {
    // Creating a mock user
    final user = MockUser();
    late AuthenticationRepository authenticationRepository;

    // Setting up mock responses for the authentication repository
    setUp(() {
      authenticationRepository = MockAuthenticationRepository();
      // When the user getter is called on the repository, return an empty stream
      when(() => authenticationRepository.user).thenAnswer(
        (_) => const Stream.empty(),
      );
      // When the currentUser getter is called on the repository, return an empty user
      when(
        () => authenticationRepository.currentUser,
      ).thenReturn(User.empty);
    });

    // Testing that the initial state is unauthenticated when the user is empty
    test('initial state is unauthenticated when user is empty', () {
      expect(
        AppBloc(authenticationRepository: authenticationRepository).state,
        const AppState.unauthenticated(),
      );
    });

    // Grouping tests related to 'UserChanged' event
    group('UserChanged', () {
      // Testing that the state is authenticated when the user is not empty
      blocTest<AppBloc, AppState>(
        'emits authenticated when user is not empty',
        setUp: () {
          // When the isNotEmpty getter is called on the user, return true
          when(() => user.isNotEmpty).thenReturn(true);
          // When the user getter is called on the repository, return a stream with the user
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        seed: AppState.unauthenticated,
        expect: () => [AppState.authenticated(user)],
      );

      // Testing that the state is unauthenticated when the user is empty
      blocTest<AppBloc, AppState>(
        'emits unauthenticated when user is empty',
        setUp: () {
          // When the user getter is called on the repository, return a stream with an empty user
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        expect: () => [const AppState.unauthenticated()],
      );
    });

    // Grouping tests related to 'LogoutRequested' event
    group('LogoutRequested', () {
      // Testing that the logOut method is called when 'LogoutRequested' event is added
      blocTest<AppBloc, AppState>(
        'invokes logOut',
        setUp: () {
          // When the logOut method is called on the repository, return a future that completes immediately
          when(
            () => authenticationRepository.logOut(),
          ).thenAnswer((_) async {});
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(const AppLogoutRequested()),
        verify: (_) {
          // Verify that the logOut method was called exactly once
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });
  });
}
