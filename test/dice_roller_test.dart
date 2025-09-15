import 'package:dice_roller/dice_roller.dart';
import 'package:test/test.dart';

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

    test('string roll is immutable', () {
      final r = DiceRoller().withDie(StringDie(['a', 'b', 'c'])).roll();
      expect(() => r.values.add('x'), throwsUnsupportedError);
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

    test('seed produces deterministic rolls', () {
      final r1 = DiceRoller()
          .seed(42)
          .withDie(TwentySidedDie())
          .withDiceCount(3)
          .roll()
          .values;
      final r2 = DiceRoller()
          .seed(42)
          .withDie(TwentySidedDie())
          .withDiceCount(3)
          .roll()
          .values;
      expect(r1, r2);
    });

    test('can roll enum dice', () {
      final diceRoller = DiceRoller().withDie(EnumDie(MyEnum.values));
      final result = diceRoller.roll();
      expect(result.values, hasLength(1));
      expect(result.values.first, isIn(MyEnum.values));
    });

    test('different seeds produce different rolls', () {
      final r1 = DiceRoller()
          .seed(1)
          .withDie(TenSidedDie())
          .withDiceCount(10)
          .roll()
          .values;
      final r2 = DiceRoller()
          .seed(2)
          .withDie(TenSidedDie())
          .withDiceCount(10)
          .roll()
          .values;
      expect(r1, isNot(equals(r2)));
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

    test('toString includes total for numeric rolls', () {
      final r = RollResult.constant([1, 2, 3]);
      expect(r.toString(), contains('totalValue'));
    });

    test('toString excludes total for non-numeric rolls', () {
      final r = RollResult.constant(['a', 'b']);
      expect(r.toString(), isNot(contains('totalValue')));
    });
  });

  group('Die', () {
    test('a die must have at least two faces', () {
      expect(() => IntDie([1]), throwsArgumentError);
      expect(() => StringDie(['a']), throwsArgumentError);
      expect(() => EnumDie([MyEnum.a]), throwsArgumentError);
    });

    test('die faces are unmodifiable', () {
      final die = SixSidedDie();
      expect(() => die.faces.add(7), throwsUnsupportedError);
    });
  });

  group('Default Dice', () {
    final cases = <Die<int>, int>{
      TwentySidedDie(): 20,
      TwelveSidedDie(): 12,
      TenSidedDie(): 10,
      EightSidedDie(): 8,
      SixSidedDie(): 6,
      FourSidedDie(): 4,
    };
    cases.forEach((die, len) {
      test('${die.runtimeType} has $len faces', () {
        expect(die.faces, equals(List.generate(len, (i) => i + 1)));
      });
    });
  });
}

enum MyEnum { a, b, c }
