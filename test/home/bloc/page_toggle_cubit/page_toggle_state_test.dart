import 'package:flutter_test/flutter_test.dart';
import 'package:snuggle_tales/home/home.dart';

void main() {
  group('PageToggleState', () {
    // Test to check if the PageToggleState is initialized with the correct index
    test('should initialize with correct index', () {
      const index = 1;
      const state = PageToggleState(index);
      expect(state.pageIndex, index);
    });
  });
}
