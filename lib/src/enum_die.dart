import 'package:dice_roller/src/die.dart';

/// A die whose faces are backed by an `Enum`.
class EnumDie<T extends Enum> extends Die<T> {
  EnumDie(super.faces);
}
