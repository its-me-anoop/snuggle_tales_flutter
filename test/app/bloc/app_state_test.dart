// Importing required packages and modules
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:snuggle_tales/app/app.dart';
import 'package:snuggle_tales/models/user_model.dart';

// Mock class for User
class MockUser extends Mock implements User {}

void main() {
  // Grouping tests under 'AppState'
  group('AppState', () {
    // Grouping tests under 'unauthenticated'
    group('unauthenticated', () {
      // Testing that the initial state is unauthenticated
      test('has correct status', () {
        // Creating an unauthenticated state
        const state = AppState.unauthenticated();

        // Expecting the status to be unauthenticated and the user to be empty
        expect(state.status, AppStatus.unauthenticated);

        // Expecting the user to be empty
        expect(state.user, User.empty);
      });
    });

    // Grouping tests under 'AppState'
    group('authenticated', () {
      test('has correct status', () {
        // Creating a mock user
        final user = MockUser();

        // Creating an authenticated state
        final state = AppState.authenticated(user);

        // Expecting the status to be authenticated and the user to be the mock user
        expect(state.status, AppStatus.authenticated);

        // Expecting the user to be the mock user
        expect(state.user, user);
      });
    });
  });
}
