library nintendart.src.cpu.cpsr;

enum InstructionSet { ARM, THUMB }

enum CPUMode { USER, FIQ, IRQ, SUPERVISOR, ABORT, UNDEFINED, SYSTEM }

/// The current program status register.  Maintains condition flags, interrupt
/// disable bits, the current processor mode and other status and control
/// information.
///
/// The bit map for ARMv4 is as follows:
///
/// |31|30|29|28|27    25|24|23     8|7|6|5|4    0|
/// |N |Z |C |V |Reserved|J |Reserved|I|F|T|M[4:0]|
class CPSR {
  int bits = 0;
  
  bool get disableIRQInterrupts => _I == 1;
 
  bool get disableFIQInterrupts => _F == 1;

  /// Returns the current [CPUMode].
  CPUMode get currentCPUMode {
    switch (_MODE) {
      case 0x0:
        return CPUMode.USER;
      case 0x1:
        return CPUMode.FIQ;
      case 0x2:
        return CPUMode.IRQ;
      case 0x3:
        return CPUMode.SUPERVISOR;
      case 0x7:
        return CPUMode.ABORT;
      case 0xB:
        return CPUMode.UNDEFINED;
      case 0xF:
        return CPUMode.SYSTEM;
    }
  }

  InstructionSet get currentInstructionSet {
    if (_J == 0) {
      if (_T == 0) {
        return InstructionSet.ARM;
      } else {
        return InstructionSet.THUMB;
      }
    } else {
      throw new UnimplementedError();
    }
  }

  /// Set to bit 31 of the result of the instruction. If this result is
  /// regarded as a two's complement signed integer, then N = 1 if the result
  /// is negative and N = 0 if it is positive or zero.
  int get NZCV => (bits >> 28) & 0xF;

  /// Together with the T bit, selects the current instruction set.
  ///
  /// We are using a T-variant ARM CPU so T is not treated as a reseved bit.
  ///
  /// The instruction set is determined by the following table:
  ///
  /// J T Instruction set
  /// -------------------
  /// 0 0 ARM
  /// 0 1 Thumb
  /// 1 0 Jazelle (Not supported on ARMv4)
  /// 1 1 RESERVED (I don't know what this does yet)
  int get _J => (bits >> 24) & 0x1;
  int get _T => (bits >> 5) & 0x1;

  /// Disables IRQ interrupts when it is set.
  int get _I => (bits >> 7) & 0x1;

  /// Disables FIQ interrupts when it is set.
  int get _F => (bits >> 6) & 0x1;

  /// M[4:0] in the above diagram.  These are the mode bits. These determine the
  /// mode in which the processor operates.
  ///
  /// The most signifant bit is always 1 and is implicit.
  int get _MODE => bits & 0xF;
}
