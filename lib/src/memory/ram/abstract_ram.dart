library nintendart.src.memory.ram.abstract_ram;

import 'dart:typed_data';

import 'package:nintendart/src/memory/memory_access.dart';

/// A partial implementation of RAM.
abstract class AbstractRAM implements MemoryAccess {
  // RAW memory for R/W 8-bit integers.
  final Uint8List _view8;

  // RAW memory for R/W 16-bit integers.
  final Uint16List _view16;

  // RAW memory for R/W 32-bit integers.
  final Uint32List _view32;

  /// Create a new RAM view on top of [buffer].
  AbstractRAM(ByteBuffer buffer)
      : _view8 = new Uint8List.view(buffer),
        _view16 = new Uint16List.view(buffer),
        _view32 = new Uint32List.view(buffer);

  @override
  int read8(int address) => _view8[address];

  @override
  int read16(int address) => _view16[address];

  @override
  int read32(int address) => _view32[address];

  @override
  void write8(int address, int value) {
    _view8[address] = value;
  }

  @override
  void write16(int address, int value) {
    _view16[address] = value;
  }

  @override
  void write32(int address, int value) {
    _view32[address] = value;
  }
}

/// Reads and writes with a [mask] value.
abstract class MaskMemoryMixin implements AbstractRAM {
  /// The mask value.
  int get mask;

  @override
  int read8(int address) => _view8[address & mask];

  @override
  int read16(int address) => _view16[address & mask];

  @override
  int read32(int address) => _view32[address & mask];

  @override
  void write8(int address, int value) {
    _view8[address & mask] = value;
  }

  @override
  void write16(int address, int value) {
    _view16[address] = value;
  }

  @override
  void write32(int address, int value) {
    _view32[address] = value;
  }
}

/// Prevents reading from the RAM.
abstract class UnreadableMemoryMixin implements MemoryAccess {
  @override
  int read8(int address) => 0;

  @override
  int read16(int address) => 0;

  @override
  int read32(int address) => 0;
}

/// Prevents writing to the RAM.
abstract class UnwriteableMemoryMixin implements MemoryAccess {
  @override
  void write8(int address, int value) {}

  @override
  void write16(int address, int value) {}

  @override
  void write32(int address, int value) {}
}
