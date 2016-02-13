library nintendart.src.memory;

import 'dart:typed_data';

const int _RAM_SIZE_BIOS = 0x4000;
const int _RAM_SIZE_EXTERNAL = 0x40000;
const int _RAM_SIZE_INTERNAL = 0x8000;

/// Encapsulates access to the RAM.
class Memory {
  final ByteBuffer _rawBuffer;

  /// Reserved RAM for BIOS use (16-bit).
  final List<int> bios16;

  /// Reserved RAM for BIOS use (32-bit).
  final List<int> bios32;

  /// Reserved RAM for application use (16-bit).
  final List<int> external16;

  /// Reserved RAM for application use (32-bit).
  final List<int> external32;

  /// Reserved RAM for internal use (16-bit).
  final List<int> internal16;

  /// Reserved RAM for internal use (32-bit).
  final List<int> internal32;

  /// Create a new empty [Memory] space.
  factory Memory() {
    const size = _RAM_SIZE_BIOS + _RAM_SIZE_EXTERNAL + _RAM_SIZE_INTERNAL;
    return new Memory.fromBuffer(new Uint8List(size).buffer);
  }

  /// Creates a [Memory] view from a [rawBuffer] of RAM.
  factory Memory.fromBuffer(ByteBuffer rawBuffer) {
    var biosView = new Uint8List.view(rawBuffer, 0, _RAM_SIZE_BIOS);
    var externalView =
        new Uint8List.view(rawBuffer, _RAM_SIZE_BIOS, _RAM_SIZE_EXTERNAL);
    var internalView = new Uint8List.view(
        rawBuffer, _RAM_SIZE_BIOS + _RAM_SIZE_EXTERNAL, _RAM_SIZE_INTERNAL);
    return new Memory._(rawBuffer, biosView, externalView, internalView);
  }

  Memory._(this._rawBuffer, Uint8List biosView, Uint8List externalView,
      Uint8List internalView)
      : bios16 = new Uint16List.view(biosView.buffer),
        bios32 = new Uint32List.view(biosView.buffer),
        external16 = new Uint16List.view(externalView.buffer),
        external32 = new Uint32List.view(externalView.buffer),
        internal16 = new Uint16List.view(internalView.buffer),
        internal32 = new Uint32List.view(internalView.buffer);
}
