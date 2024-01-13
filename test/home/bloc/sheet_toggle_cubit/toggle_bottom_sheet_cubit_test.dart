import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snuggle_tales/home/home.dart';

void main() {
  group('ToggleBottomSheetCubit', () {
    // Test to check if the ToggleBottomSheetCubit emits the correct state when toggleSheet is called
    blocTest<SheetToggleCubit, SheetToggleState>(
      'should emit sheetToggleState as true when toggleSheetOpen is called',
      build: () => SheetToggleCubit(),
      act: (cubit) => cubit.toggleSheetOpen(),
      expect: () =>
          [const SheetToggleState(true)], // assuming initial state is false
    );
    // Test to check if the ToggleBottomSheetCubit emits the correct state when toggleSheetClosed is called
    blocTest<SheetToggleCubit, SheetToggleState>(
      'should emit sheetToggleState as false when toggleSheetClosed is called',
      build: () => SheetToggleCubit(),
      act: (cubit) => cubit.toggleSheetClosed(),
      expect: () =>
          [const SheetToggleState(false)], // assuming initial state is false
    );
  });
}
