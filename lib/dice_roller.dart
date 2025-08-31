import 'package:dice_roller/roll_result.dart';
export 'roll_result.dart';

class DiceRoller {
  const DiceRoller();

  RollResult roll({int count = 3, int sides = 6}) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'must be at least 1 die');
    }
    if (sides <= 0) {
      throw ArgumentError.value(
          sides, 'sides', 'die must have at least 1 side');
    }
    // Stubbed result; replace with RNG in a follow-up.
    return RollResult.unmodifiable([1, 2, 3]);
  }
}
