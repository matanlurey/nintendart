library nintendart.test.cpu.cpsr_test;

import 'package:nintendart/src/cpu/cpsr.dart';
import 'package:test/test.dart';

void main() {
  group('CPSR', () {
    CPSR cpsr;

    setUp(() {
      cpsr = new CPSR();
    });

    test('NZCV should return a nibble of the 4 most significant bits', () {
      cpsr.bits = 0xF0000000;
      expect(cpsr.NZCV, 0xF);
    });

    test('Q should return the 27th bit', () {
      cpsr.bits = 0x08000000;
      expect(cpsr.Q, 0x1);
    });
    
    test('J should return the 24th bit', () {
      cpsr.bits = 0x01000000;
      expect(cpsr.J, 0x1);
    });
    
    test('T should return the 5th bit', () {
      cpsr.bits = 0x00000020;
      expect(cpsr.T, 0x1);
    });

    test('A should return the 8th bit', () {
      cpsr.bits = 0x00000100;
      expect(cpsr.A, 0x1);
    });

    test('I should return the 7th bit', () {
      cpsr.bits = 0x00000080;
      expect(cpsr.I, 0x1);
    });

    test('F should return the 6th bit', () {
      cpsr.bits = 0x00000040;
      expect(cpsr.F, 0x1);
    });
    
    test('MODE should return the 4 least significant bits', () {
      cpsr.bits = 0x0000000F;
      expect(cpsr.MODE, 0xF);
    });
  });
}
