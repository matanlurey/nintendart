library nintendart.test.memory.ram_bios_test;

import 'dart:typed_data';

import 'package:nintendart/src/memory/memory_access.dart';
import 'package:nintendart/src/memory/ram/bios_ram.dart';
import 'package:test/test.dart';

void main() {
  group('$BiosRAM', () {
    Uint8List list;
    MemoryAccess memory;

    setUp(() {
      list = new Uint8List(32);
      memory = new BiosRAM(list.buffer);
    });

    test('should prevent writing', () {
      memory.write8(0, 1);
      expect(list, new List.filled(32, 0));

      memory.write16(0, 1);
      expect(list, new List.filled(32, 0));

      memory.write32(0, 1);
      expect(list, new List.filled(32, 0));
    });

    test('should allow reading', () {
      list[0] = 100;
      expect(memory.read8(0), 100);
      expect(memory.read16(0), 100);
      expect(memory.read32(0), 100);
    });

    test('should prevent reading if the BIOS is protected', () {
      list[0] = 100;
      memory = new BiosRAM(list.buffer, () => true);
      expect(memory.read8(0), 0);
      expect(memory.read16(0), 0);
      expect(memory.read32(0), 0);
    });
  });
}
