import 'dart:math';

import 'package:dice_roller/roll_result.dart';
export 'roll_result.dart';

/// A class that simulates rolling dice.
///
/// The [DiceRoller] class is mutable, allowing you to change the number of dice
/// and sides on the dice.
class DiceRoller {
  int _diceCount = 1;
  int _sides = 6;
  Random _rng = Random();

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

  /// Sets the number of sides on each die.
  ///
  /// Throws an [ArgumentError] if [sides] is less than 2.
  DiceRoller withTotalSides(int sides) {
    if (sides < 2) {
      throw ArgumentError.value(
          sides, 'sides', 'each die must have at least 2 sides');
    }
    _sides = sides;
    return this;
  }

  /// Rolls the dice and returns a [RollResult].
  RollResult roll() {
    final rolls = List.generate(_diceCount, (_) => _rng.nextInt(_sides) + 1);
    return RollResult.unmodifiable(rolls);
  }
}
