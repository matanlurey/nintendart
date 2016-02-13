library nintendart.test.memory_test;

import 'package:nintendart/src/memory.dart';
import 'package:test/test.dart';

void main() {
  group('$Memory', () {
    test('should create a default Memory view', () {
      var memory = new Memory();
      expect(memory, isNotNull);
    });
  });
}
