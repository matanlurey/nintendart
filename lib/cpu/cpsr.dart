library nintendart.cpu.cpsr;

/// The current program status register.  Maintains condition flags, interrupt
/// disable bits, the current processor mode and other status and control 
/// information.
///
/// The bit map is as follows:
///
/// |31|30|29|28|27|26 25|24|23    20|19   16|15    10|9|8|7|6|5|4    0|
/// |N |Z |C |V |Q |Res  |J |RESERVED|GE[3:0]|RESERVED|E|A|I|F|T|M[4:0]|
class CPSR {
    int bits = 0;
    
    CPSR();
    
    /// Set to bit 31 of the result of the instruction. If this result is 
    /// regarded as a two's complement signed integer, then N = 1 if the result 
    /// is negative and N = 0 if it is positive or zero.
    int get NZCV =>  (bits >> 28) & 0xF;
    
    /// The q flag. Used to indicate whether overflow and/or saturation has
    /// occurred in some DSP-oriented insructions. bit 27 of each SPSR is also 
    /// a Q flag and is used to preserve and restore the CPSR Q flag if an 
    /// exception occurs.
    int get Q => (bits >> 27) & 0x1;

    /// Together with the T bit, selects the current instruction set. 
    /// 
    /// We are using a T-variant ARM CPU so T is not treated as a reseved bit.
    ///
    /// The instruction set is determined by the following table.
    /// J T Instruction set
    /// -------------------
    /// 0 0 ARM
    /// 0 1 Thumb
    /// 1 0 Jazelle
    /// 1 1 RESERVED
    int get J => (bits >> 24) & 0x1;
    int get T => (bits >> 5) & 0x1;

    /// Contols load and store endianness for data handling.  This 
    /// instruction is ignored by instruction fetches.
    ///
    /// In architecture versions prior to ARMv6, bit[9] of the CPSR and SPSRs 
    //// must be treated as a reserved bit
    int get E => (bits >> 9) & 0x1
    
    /// Reserved bit (ARMv4)
    int get A => (bits >> 8) & 0x1;
    
    /// Disables IRQ interrupts when it is set.
    int get I => (bits >> 7) & 0x1;
    
    /// Disables FIQ interrupts when it is set.
    int get F => (bits >> 6) & 0x1;
    
    /// The mode bits. These determine the mode in which the processor operates.
    /// The most signifant bit is always 1 and is implicit.
    int get MODE => bits & 0xF;
}
