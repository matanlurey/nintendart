library nintendart.test.cpu.gprs_test;

import 'package:nintendart/src/cpu/gprs.dart';
import 'package:test/test.dart';

void main() {
  group('$GPRS', () {
    GPRS gprs;

    setUp(() {
      gprs = new GPRS();
    });

    test('should be able to read/write', () {
      gprs[0] = 1;
      gprs[1] = 2;
      gprs[2] = 3;
      expect(gprs[0], 1);
      expect(gprs[1], 2);
      expect(gprs[2], 3);
      expect(gprs.toList(), [1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    });

    test('should have getters/setters for reserved registers', () {
      gprs.stackPointer = 1;
      expect(gprs.stackPointer, 1);
      gprs.programCounter = 2;
      expect(gprs.programCounter, 2);
      expect(gprs.toList(), [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2]);
    });
  });
}
