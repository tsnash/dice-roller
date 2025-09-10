import 'package:dice_roller/src/die.dart';

class EnumDie<T extends Enum> extends Die<T> {
  EnumDie(List<T> faces) : super(faces);
}
