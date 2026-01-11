import 'dart:math';

import 'roll_result.dart';
import 'src/default_dice.dart';
import 'src/die.dart';
export 'roll_result.dart';
export 'src/die.dart';
export 'src/int_die.dart';
export 'src/string_die.dart';
export 'src/enum_die.dart';
export 'src/default_dice.dart';
export 'src/extensions.dart';

/// A class that simulates rolling dice.
///
/// A [DiceRoller] is created with a default configuration of one six-sided die.
/// The configuration can be changed by calling the [withDiceCount] and [withDie]
/// methods. The random number generator can be seeded with the [seed] method.
///
/// Example:
/// ```dart
/// import 'package:dice_roller/dice_roller.dart';
///
/// void main() {
///   // Roll a single six-sided die.
///   final result1 = DiceRoller().roll();
///   print(result1); // e.g. RollResult(values: [4], totalValue: 4)
///
///   // Roll three twenty-sided dice.
///   final result2 = DiceRoller()
///       .withDiceCount(3)
///       .withDie(TwentySidedDie())
///       .roll();
///   print(result2); // e.g. RollResult(values: [1, 19, 7], totalValue: 27)
///
///   // Roll a die with custom faces.
///   final result3 = DiceRoller()
///       .withDie(StringDie(['heads', 'tails']))
///       .roll();
///   print(result3); // e.g. RollResult(values: ['heads'])
/// }
/// ```
///
/// Note: `roll()` returns a `RollResult<dynamic>`. If the die's faces are not
/// numeric, accessing `totalValue` on the result will throw an [UnsupportedError].
class DiceRoller {
  int _diceCount = 1;
  Die<dynamic> _die = SixSidedDie();
  Random _rng = Random();

  /// Creates a new [DiceRoller].
  DiceRoller();

  /// Seeds the random number generator.
  ///
  /// Calling this method will reset the internal state of the random number
  /// generator, so subsequent calls to [roll] will produce the same sequence of
  /// numbers for a given seed.
  ///
  /// This is useful for testing.
  DiceRoller seed(int seed) {
    _rng = Random(seed);
    return this;
  }

  /// Sets the number of dice to roll.
  ///
  /// The default is 1.
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
  ///
  /// The default is a [SixSidedDie].
  DiceRoller withDie(Die<dynamic> die) {
    _die = die;
    return this;
  }

  /// Rolls the dice and returns a [RollResult].
  ///
  /// The type of the values in the [RollResult] will match the type of the
  /// faces of the die.
  RollResult<dynamic> roll() {
    final faces = _die.faces;
    final length = faces.length;
    final rolls = List.generate(_diceCount, (_) => faces[_rng.nextInt(length)]);
    return RollResult(rolls);
  }
}
