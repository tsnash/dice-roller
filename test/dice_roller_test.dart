import 'package:dice_roller/dice_roller.dart';
import 'package:flutter_test/flutter_test.dart';

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
      expect(() => result.values.add(4), throwsUnsupportedError);
    });

    test('can change the number of dice to roll', () {
      final diceRoller = DiceRoller();
      diceRoller.withDiceCount(2);
      expect(diceRoller.roll().values, hasLength(2));
    });

    test('default die is six sided', () {
      final diceRoller = DiceRoller();
      final result = diceRoller.roll();
      expect(result.values, hasLength(1));
      expect(result.values.first, isIn([1, 2, 3, 4, 5, 6]));
    });

    test('can change the die', () {
      final diceRoller = DiceRoller();
      diceRoller.withDie(TwentySidedDie());
      final result = diceRoller.roll();
      expect(result.values, hasLength(1));
      expect(result.values.first, inInclusiveRange(1, 20));
    });

    test('can roll different types of dice', () {
      final stringDie = StringDie(['a', 'b', 'c']);
      final diceRoller = DiceRoller().withDie(stringDie);
      final result = diceRoller.roll();
      expect(result.values, hasLength(1));
      expect(result.values.first, isIn(['a', 'b', 'c']));
    });

    test('can chain methods', () {
      final diceRoller = DiceRoller();
      final chained = diceRoller.withDie(TenSidedDie()).withDiceCount(3);
      expect(identical(chained, diceRoller), isTrue);
      final result = diceRoller.roll().values;
      expect((result), hasLength(3));
      expect(result, everyElement(inInclusiveRange(1, 10)));
    });

    test('invalid inputs throw', () {
      expect(() => DiceRoller().withDiceCount(0), throwsArgumentError);
    });

    test('boundary values are accepted', () {
      expect(() => DiceRoller().withDiceCount(1), returnsNormally);
    });

    test('negative values throw', () {
      expect(() => DiceRoller().withDiceCount(-1), throwsArgumentError);
    });
  });

  group('RollResult', () {
    test('totalValue returns the sum of rolls', () {
      final result = RollResult.constant([1, 2, 3]);
      expect(result.totalValue, 6);
    });

    test('totalValue throws for non-numeric types', () {
      final result = RollResult.constant(['a', 'b', 'c']);
      expect(() => result.totalValue, throwsUnsupportedError);
    });

    test('values returns the individual rolls', () {
      final result = RollResult.constant([1, 2, 3]);
      expect(result.values, [1, 2, 3]);
    });

    test('same roll results are equal', () {
      final result1 = RollResult.constant([1, 2, 3]);
      final result2 = RollResult.unmodifiable([1, 2, 3]);
      expect(result1, equals(result2));
      expect({result1}, contains(result2));
    });

    test('RollResult is independent of input list mutations', () {
      final input = [1, 2, 3];
      final result = RollResult.constant(input);
      input[0] = 99;
      expect(result.values, [1, 2, 3]);
    });
  });

  group('Die', () {
    test('a die must have at least two faces', () {
      expect(() => IntDie([1]), throwsArgumentError);
      expect(() => StringDie(['a']), throwsArgumentError);
      expect(() => EnumDie([MyEnum.a]), throwsArgumentError);
    });
  });

  group('Default Dice', () {
    test('TwentySidedDie has 20 faces', () {
      expect(TwentySidedDie().faces, hasLength(20));
      expect(TwentySidedDie().faces.first, 1);
      expect(TwentySidedDie().faces.last, 20);
    });
    test('TwelveSidedDie has 12 faces', () {
      expect(TwelveSidedDie().faces, hasLength(12));
      expect(TwelveSidedDie().faces.first, 1);
      expect(TwelveSidedDie().faces.last, 12);
    });
    test('TenSidedDie has 10 faces', () {
      expect(TenSidedDie().faces, hasLength(10));
      expect(TenSidedDie().faces.first, 1);
      expect(TenSidedDie().faces.last, 10);
    });
    test('EightSidedDie has 8 faces', () {
      expect(EightSidedDie().faces, hasLength(8));
      expect(EightSidedDie().faces.first, 1);
      expect(EightSidedDie().faces.last, 8);
    });
    test('SixSidedDie has 6 faces', () {
      expect(SixSidedDie().faces, hasLength(6));
      expect(SixSidedDie().faces.first, 1);
      expect(SixSidedDie().faces.last, 6);
    });
    test('FourSidedDie has 4 faces', () {
      expect(FourSidedDie().faces, hasLength(4));
      expect(FourSidedDie().faces.first, 1);
      expect(FourSidedDie().faces.last, 4);
    });
  });
}

enum MyEnum { a, b, c }
