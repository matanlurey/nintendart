library nintendart.src.memory.ram.bios_ram;

import 'dart:typed_data';

import 'package:nintendart/src/memory/ram/abstract_ram.dart';

/// A function that should return whether the BIOS is protected.
///
/// This should return true if `CPU::reg[15].I >> 24`.
typedef bool IsBIOSProtected();

/// Bios-based RAM.
///
/// It is illegal to write to this RAM area.
///
/// It is illegal to read from this RAM area when the BIOS is not currently
/// executed (this is "BIOS protected memory").
class BiosRAM extends AbstractRAM with MaskMemoryMixin, UnwriteableMemoryMixin {
  static bool _disableBIOSProtection() => false;

  final IsBIOSProtected _isBIOSProtected;

  @override
  final int mask = 0x00003FFF;

  BiosRAM(ByteBuffer buffer, [this._isBIOSProtected = _disableBIOSProtection])
      : super(buffer);

  @override
  int read8(int address) {
    if (_isBIOSProtected()) {
      return 0;
    }
    return super.read8(address);
  }

  @override
  int read16(int address) {
    if (_isBIOSProtected()) {
      return 0;
    }
    return super.read16(address);
  }

  @override
  int read32(int address) {
    if (_isBIOSProtected()) {
      return 0;
    }
    return super.read32(address);
  }
}
