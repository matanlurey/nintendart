library nintendart.test.memory.memory_manager_test;

import 'package:nintendart/src/memory/memory_manager.dart';
import 'package:test/test.dart';

void main() {
  group('$MemoryManager', () {
    test('can be created', () {
      expect(new MemoryManager().getRAMBuffer(), hasLength(0x6cc00));
    });
  });
}
