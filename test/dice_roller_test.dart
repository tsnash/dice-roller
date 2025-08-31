import 'package:flutter_test/flutter_test.dart';

import 'package:dice_roller/dice_roller.dart';
import 'package:dice_roller/roll_result.dart';

void main() {
  group('DiceRoller', () {
    test('roll returns a RollResult', () {
      final diceRoller = DiceRoller();
      final result = diceRoller.roll();
      expect(result, isA<RollResult>());
    });
  });

  group('RollResult', () {
    test('total returns the sum of rolls', () {
      const result = RollResult([1, 2, 3]);
      expect(result.total, 6);
    });

    test('rolls returns the individual rolls', () {
      const result = RollResult([1, 2, 3]);
      expect(result.rolls, [1, 2, 3]);
    });
  });
}
