library nintendart.src.cpu.gprs;

import 'dart:typed_data';

/// General purpose registers.
///
/// https://en.wikipedia.org/wiki/Processor_register
class GPRS {
  static const int _INDEX_STACK_POINTER = 13;
  static const int _INDEX_PROGRAM_COUNTER = 15;
  static const int _MAX_REGISTERS = 16;

  final Uint32List _registers;

  /// Create a new, empty [GPRS].
  GPRS() : _registers = new Uint32List(_MAX_REGISTERS);

  /// Create a new [GPRS] using the provided [values].
  GPRS.fromRegisters(List<int> values)
      : _registers = new Uint32List.fromList(values);

  /// Return the value of the register [n].
  int operator [](int n) => _registers[n];

  /// Set the value of the register [n] to [v].
  void operator []=(int n, int v) {
    _registers[n] = v;
  }

  /// Stack pointer.
  int get stackPointer => _registers[_INDEX_STACK_POINTER];
  void set stackPointer(int stackPointer) {
    _registers[_INDEX_STACK_POINTER] = stackPointer;
  }

  /// Program counter.
  int get programCounter => _registers[_INDEX_PROGRAM_COUNTER];
  void set programCounter(int programCounter) {
    _registers[_INDEX_PROGRAM_COUNTER] = programCounter;
  }

  /// Return a list copy of this register.
  List<int> toList() => _registers.toList();
}
