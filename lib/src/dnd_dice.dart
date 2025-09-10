import 'package:dice_roller/src/int_die.dart';

class TwentySidedDie extends IntDie {
  TwentySidedDie() : super(List.generate(20, (i) => i + 1));
}

class TwelveSidedDie extends IntDie {
  TwelveSidedDie() : super(List.generate(12, (i) => i + 1));
}

class TenSidedDie extends IntDie {
  TenSidedDie() : super(List.generate(10, (i) => i + 1));
}

class EightSidedDie extends IntDie {
  EightSidedDie() : super(List.generate(8, (i) => i + 1));
}

class SixSidedDie extends IntDie {
  SixSidedDie() : super(List.generate(6, (i) => i + 1));
}

class FourSidedDie extends IntDie {
  FourSidedDie() : super(List.generate(4, (i) => i + 1));
}
