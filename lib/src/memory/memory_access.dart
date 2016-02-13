library nintendart.src.memory.memory_access;

/// A memory map definition.
///
/// Defines a limited interface for I/O to a specific RAM space.
abstract class MemoryAccess {
  /// Reads a 8-bit integer at [address].
  int read8(int address);

  /// Reads a 16-bit integer at [address].
  int read16(int address);

  /// Reads a 32-bit integer at [address].
  int read32(int address);

  /// Writes a 8-bit integer [value] to [address].
  void write8(int address, int value);

  /// Writes a 16-bit integer [value] to [address].
  void write16(int address, int value);

  /// Writes a 32-bit integer [value] to [address].
  void write32(int address, int value);
}
