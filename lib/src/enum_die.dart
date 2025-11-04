import 'die.dart';

/// A die whose faces are backed by an `Enum`.
class EnumDie<T extends Enum> extends Die<T> {
  /// Creates a die with the given enum faces.
  EnumDie(super.faces);
}
