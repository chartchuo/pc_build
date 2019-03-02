import 'cpu.dart';
import 'vga.dart';
import 'mb.dart';

export 'cpu.dart';
export 'vga.dart';
export 'mb.dart';

class Pc {
  Cpu cpu;
  Mb mb;
  Vga vga;
}
