import 'dart:math';

import 'package:dice_roller/roll_result.dart';
import 'package:dice_roller/src/default_dice.dart';
import 'package:dice_roller/src/die.dart';
export 'roll_result.dart';
export 'src/die.dart';
export 'src/int_die.dart';
export 'src/string_die.dart';
export 'src/enum_die.dart';
export 'src/default_dice.dart';

/// A class that simulates rolling dice.
///
/// The [DiceRoller] class is mutable, allowing you to change the number of dice
/// and the die to be rolled.
class DiceRoller {
  int _diceCount = 1;
  Die<dynamic> _die = SixSidedDie();
  Random _rng = Random();

  DiceRoller();

  /// Seeds the random number generator.
  ///
  /// Calling this method will reset the internal state of the random number generator,
  /// so subsequent calls to [roll] will produce the same sequence of numbers
  /// for a given seed.
  DiceRoller seed(int seed) {
    _rng = Random(seed);
    return this;
  }

  /// Sets the number of dice to roll.
  ///
  /// Throws an [ArgumentError] if [diceCount] is less than 1.
  DiceRoller withDiceCount(int diceCount) {
    if (diceCount < 1) {
      throw ArgumentError.value(
          diceCount, 'diceCount', 'there must be at least 1 die');
    }
    _diceCount = diceCount;
    return this;
  }

  /// Sets the die to be rolled.
  DiceRoller withDie(Die<dynamic> die) {
    _die = die;
    return this;
  }

  /// Rolls the dice and returns a [RollResult].
  RollResult<dynamic> roll() {
    final faces = _die.faces;
    final rolls =
        List.generate(_diceCount, (_) => faces[_rng.nextInt(faces.length)]);
    return RollResult.unmodifiable(rolls);
  }
}
