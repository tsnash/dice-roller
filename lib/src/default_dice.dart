import 'int_die.dart';

class TwentySidedDie extends IntDie {
  static final List<int> _faces = List.generate(20, (i) => i + 1);
  TwentySidedDie() : super(_faces);
}

class TwelveSidedDie extends IntDie {
  static final List<int> _faces = List.generate(12, (i) => i + 1);
  TwelveSidedDie() : super(_faces);
}

class TenSidedDie extends IntDie {
  static final List<int> _faces = List.generate(10, (i) => i + 1);
  TenSidedDie() : super(_faces);
}

class EightSidedDie extends IntDie {
  static final List<int> _faces = List.generate(8, (i) => i + 1);
  EightSidedDie() : super(_faces);
}

class SixSidedDie extends IntDie {
  static final List<int> _faces = List.generate(6, (i) => i + 1);
  SixSidedDie() : super(_faces);
}

class FourSidedDie extends IntDie {
  static final List<int> _faces = List.generate(4, (i) => i + 1);
  FourSidedDie() : super(_faces);
}
