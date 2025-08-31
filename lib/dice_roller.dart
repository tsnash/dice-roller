import 'package:dice_roller/roll_result.dart';
export 'roll_result.dart';

class DiceRoller {
  var _diceCount = 1;
  var _sides = 6;

  DiceRoller setDiceCount(int count) {
    _diceCount = count;
    return this;
  }

  DiceRoller setSides(int sides) {
    _sides = sides;
    return this;
  }

  RollResult roll() {
    if (_diceCount <= 0) {
      throw ArgumentError.value(
          _diceCount, 'count', 'must be at least 1 die');
    }
    if (_sides <= 0) {
      throw ArgumentError.value(
          _sides, 'sides', 'die must have at least 1 side');
    }
    // Stubbed result; replace with RNG in a follow-up.
    final rolls = List.generate(_diceCount, (_) => 1);
    return RollResult.unmodifiable(rolls);
  }
}
