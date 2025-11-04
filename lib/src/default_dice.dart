import 'int_die.dart';

/// A standard twenty-sided die.
class TwentySidedDie extends IntDie {
  static final List<int> _faces = List.generate(20, (i) => i + 1);

  /// Creates a twenty-sided die.
  TwentySidedDie() : super(_faces);
}

/// A standard twelve-sided die.
class TwelveSidedDie extends IntDie {
  static final List<int> _faces = List.generate(12, (i) => i + 1);

  /// Creates a twelve-sided die.
  TwelveSidedDie() : super(_faces);
}

/// A standard ten-sided die.
class TenSidedDie extends IntDie {
  static final List<int> _faces = List.generate(10, (i) => i + 1);

  /// Creates a ten-sided die.
  TenSidedDie() : super(_faces);
}

/// A standard eight-sided die.
class EightSidedDie extends IntDie {
  static final List<int> _faces = List.generate(8, (i) => i + 1);

  /// Creates an eight-sided die.
  EightSidedDie() : super(_faces);
}

/// A standard six-sided die.
class SixSidedDie extends IntDie {
  static final List<int> _faces = List.generate(6, (i) => i + 1);

  /// Creates a six-sided die.
  SixSidedDie() : super(_faces);
}

/// A standard four-sided die.
class FourSidedDie extends IntDie {
  static final List<int> _faces = List.generate(4, (i) => i + 1);

  /// Creates a four-sided die.
  FourSidedDie() : super(_faces);
}
