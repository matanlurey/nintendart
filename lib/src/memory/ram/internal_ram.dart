library nintendart.src.memory.ram.internal_ram;

import 'dart:typed_data';

import 'package:nintendart/src/memory/ram/abstract_ram.dart';

/// RAM for internal use?
class InternalRAM extends AbstractRAM with MaskMemoryMixin {
  @override
  final int mask = 0x00007FFF;

  InternalRAM(ByteBuffer buffer) : super(buffer);
}
