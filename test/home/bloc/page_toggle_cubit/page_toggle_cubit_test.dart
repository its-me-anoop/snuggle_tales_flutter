import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snuggle_tales/home/home.dart';

void main() {
  group('PageToggleCubit', () {
    // Test to check if the PageToggleCubit emits the correct state when setPageIndex is called
    blocTest<PageToggleCubit, PageToggleState>(
      'should emit PageToggleState with the correct index when setPageIndex is called',
      build: () => PageToggleCubit(),
      act: (cubit) => cubit.setPageIndex(1),
      expect: () => [const PageToggleState(1)],
    );
  });
}
