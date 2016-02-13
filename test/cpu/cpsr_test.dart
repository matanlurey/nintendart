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

    test('currentCPUMode should return the correct CPUMode', () {
      cpsr.bits = 0x0;
      expect(cpsr.currentCPUMode, CPUMode.USER);
      cpsr.bits = 0x00000001;
      expect(cpsr.currentCPUMode, CPUMode.FIQ);
      cpsr.bits = 0x00000002;
      expect(cpsr.currentCPUMode, CPUMode.IRQ);
      cpsr.bits = 0x00000003;
      expect(cpsr.currentCPUMode, CPUMode.SUPERVISOR);
      cpsr.bits = 0x00000007;
      expect(cpsr.currentCPUMode, CPUMode.ABORT);
      cpsr.bits = 0x0000000B;
      expect(cpsr.currentCPUMode, CPUMode.UNDEFINED);
      cpsr.bits = 0x0000000F;
      expect(cpsr.currentCPUMode, CPUMode.SYSTEM);
    });
    
    test('currentInstructionSet should return the 24th bit', () {
      cpsr.bits = 0x00000020; // J and T are 0 and 1
      expect(cpsr.currentInstructionSet, InstructionSet.THUMB);
      cpsr.bits = 0x00000000; // J and T are 0 and 0
      expect(cpsr.currentInstructionSet, InstructionSet.ARM);
    });
    
    test('disableIRQInterrupts should return true iff the 7th bit is set.', () {
      cpsr.bits = 0x00000080;
      expect(cpsr.disableIRQInterrupts, isTrue);
      cpsr.bits = 0x00000000;
      expect(cpsr.disableIRQInterrupts, isFalse);
    });

    test('disableFIQInterrupts should return true iff the 6th bit is set.', () {
      cpsr.bits = 0x00000040;
      expect(cpsr.disableFIQInterrupts, isTrue);
      cpsr.bits = 0x00000000;
      expect(cpsr.disableFIQInterrupts, isFalse);
    });
  });
}
