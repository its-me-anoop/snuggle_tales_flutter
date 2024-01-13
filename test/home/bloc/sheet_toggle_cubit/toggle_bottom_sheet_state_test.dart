// Test to check if the ToggleBottomSheetCubit emits the correct state when toggleSheet is called
import 'package:flutter_test/flutter_test.dart';
import 'package:snuggle_tales/home/home.dart';

void main() {
  group('SheetToggleState', () {
    // Test to check if the SheetToggleState is initialized with the correct isSheetOpen value
    test('should initialize with correct isSheetOpen value', () {
      const isSheetOpen = true;
      const state = SheetToggleState(isSheetOpen);
      expect(state.isSheetOpen, isSheetOpen);
    });
  });
}
