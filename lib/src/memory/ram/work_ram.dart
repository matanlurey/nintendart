library nintendart.src.memory.ram.work_ram;

import 'dart:typed_data';

import 'package:nintendart/src/memory/ram/abstract_ram.dart';

/// RAM for the working application.
class WorkRAM extends AbstractRAM with MaskMemoryMixin {
  @override
  final int mask = 0x0003FFFF;

  WorkRAM(ByteBuffer buffer) : super(buffer);
}
