import 'package:dice_roller/src/die.dart';

class EnumDie<T extends Enum> extends Die<T> {
  EnumDie(super.faces);
}
