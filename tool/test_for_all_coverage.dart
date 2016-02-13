library nintendart.tool.test_all_for_coverage;

import 'package:test/test.dart';

import '../test/cpu/cpsr_test.dart' as cpu_cpsr_test;
import '../test/memory/memory_manager_test.dart' as memory_manager_test;
import '../test/memory/ram_bios_test.dart' as ram_bios_test;

void main() {
  group('cpsr_test.dart', cpu_cpsr_test.main);
  group('memory_manager_test.dart', memory_manager_test.main);
  group('ram_bios_test.dart', ram_bios_test.main);
}
