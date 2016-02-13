library nintendart.src.memory.memory_manager;

import 'dart:typed_data';

import 'package:nintendart/src/memory/memory_access.dart';
import 'package:nintendart/src/memory/ram/bios_ram.dart';
import 'package:nintendart/src/memory/ram/internal_ram.dart';
import 'package:nintendart/src/memory/ram/work_ram.dart';

const int _RAM_SIZE_BIOS = 0x4000;
const int _RAM_SIZE_WORK = 0x40000;
const int _RAM_SIZE_INTERNAL = 0x8000;
const int _RAM_SIZE_IO = 0x400;
const int _RAM_SIZE_PALETTE = 0x400;
const int _RAM_SIZE_VIDEO = 0x20000;
const int _RAM_SIZE_OBJECT = 0x400;

final int _ramSizeTotal = _RAM_SIZE_BIOS +
    _RAM_SIZE_WORK +
    _RAM_SIZE_INTERNAL +
    _RAM_SIZE_IO +
    _RAM_SIZE_PALETTE +
    _RAM_SIZE_VIDEO +
    _RAM_SIZE_OBJECT;

class MemoryManager {
  final ByteBuffer _ramBuffer;

  final MemoryAccess biosRAM;
  final MemoryAccess internalRAM;
  final MemoryAccess workRAM;

  factory MemoryManager() {
    return new MemoryManager.fromBuffer(new Uint8List(_ramSizeTotal).buffer);
  }

  MemoryManager.fromBuffer(ByteBuffer ramBuffer)
      : _ramBuffer = ramBuffer,
        biosRAM = new BiosRAM(
            new Uint8List.view(ramBuffer, 0, _RAM_SIZE_BIOS).buffer),
        internalRAM = new InternalRAM(
            new Uint8List.view(ramBuffer, _RAM_SIZE_BIOS, _RAM_SIZE_INTERNAL)
                .buffer),
        workRAM = new WorkRAM(new Uint8List.view(
                ramBuffer, _RAM_SIZE_BIOS + _RAM_SIZE_INTERNAL, _RAM_SIZE_WORK)
            .buffer);

  /// Returns a *copy* of the RAM Buffer.
  Uint8List getRAMBuffer() => new Uint8List.fromList(_ramBuffer.asUint8List());
}
