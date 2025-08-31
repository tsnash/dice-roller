import 'package:dice_roller/roll_result.dart';

class DiceRoller {
  RollResult roll() {
    // For now, it returns a hardcoded result as requested by the user.
    return const RollResult([1, 2, 3]);
  }
}
