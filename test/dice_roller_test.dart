import 'package:flutter_test/flutter_test.dart';

import 'package:dice_roller/dice_roller.dart';

void main() {
  group('DiceRoller', () {
    test('roll returns a RollResult', () {
      final diceRoller = DiceRoller();
      final result = diceRoller.roll();
      expect(result, isA<RollResult>());
    });

    test('roll is immutable', () {
      final diceRoller = DiceRoller();
      final result = diceRoller.roll();
      expect(() => result.rolls.add(4), throwsUnsupportedError);
      expect(() => result.rolls[0] = 4, throwsUnsupportedError);
    });
  });

  group('RollResult', () {
    test('total returns the sum of rolls', () {
      const result = RollResult.constant([1, 2, 3]);
      expect(result.total, 6);
    });

    test('rolls returns the individual rolls', () {
      const result = RollResult.constant([1, 2, 3]);
      expect(result.rolls, [1, 2, 3]);
    });

    test('same roll results are equal', () {
      const result1 = RollResult.constant([1, 2, 3]);
      const result2 = RollResult.constant([1, 2, 3]);
      expect(result1, equals(result2));
      expect({result1}, contains(result2));
    });
  });
}
