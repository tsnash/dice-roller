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
      final result = RollResult([1, 2, 3]);
      expect(result.totalValue, 6);
    });

    test('totalValue throws for non-numeric types', () {
      final result = RollResult(['a', 'b', 'c']);
      expect(() => result.totalValue, throwsUnsupportedError);
    });

    test('values returns the individual rolls', () {
      final result = RollResult([1, 2, 3]);
      expect(result.values, [1, 2, 3]);
    });

    test('same roll results are equal', () {
      final result1 = RollResult([1, 2, 3]);
      final result2 = RollResult([1, 2, 3]);
      expect(result1, equals(result2));
      expect({result1}, contains(result2));
    });

    test('RollResult is independent of input list mutations', () {
      final input = [1, 2, 3];
      final result = RollResult(input);
      input[0] = 99;
      expect(result.values, [1, 2, 3]);
    });

    test('toString includes total for numeric rolls', () {
      final r = RollResult([1, 2, 3]);
      expect(r.toString(), contains('totalValue'));
    });

    test('toString excludes total for non-numeric rolls', () {
      final r = RollResult(['a', 'b']);
      expect(r.toString(), isNot(contains('totalValue')));
    });

    test('valueCounts returns correct counts', () {
      final result = RollResult([1, 2, 2, 3, 3, 3]);
      final counts = result.valueCounts;
      expect(counts[1], 1);
      expect(counts[2], 2);
      expect(counts[3], 3);
      expect(counts.length, 3);
    });

    test('valueCounts is sparse', () {
      final result = RollResult([MyEnum.a, MyEnum.a, MyEnum.a]);
      final counts = result.valueCounts;
      expect(counts, {MyEnum.a: 3});
    });

    test('valueCounts works for string rolls', () {
      final result = RollResult(['a', 'b', 'a', 'c', 'b', 'a']);
      final counts = result.valueCounts;
      expect(counts, {'a': 3, 'b': 2, 'c': 1});
    });

    test('valueCounts works for enum rolls', () {
      final result = RollResult(
          [MyEnum.a, MyEnum.b, MyEnum.a, MyEnum.c, MyEnum.b, MyEnum.a]);
      final counts = result.valueCounts;
      expect(counts, {MyEnum.a: 3, MyEnum.b: 2, MyEnum.c: 1});
    });

    test('valueCounts is immutable', () {
      final result = RollResult([1, 2, 3]);
      expect(() => result.valueCounts[1] = 99, throwsUnsupportedError);
    });

    test('valueCounts returns empty map for no rolls', () {
      final result = RollResult<int>([]);
      expect(result.valueCounts, isEmpty);
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

  group('MapUtils', () {
    test('filled populates missing keys with 0', () {
      final die = SixSidedDie();
      final counts = {1: 5, 6: 2};
      final filled = counts.filled(die);
      expect(filled, {1: 5, 2: 0, 3: 0, 4: 0, 5: 0, 6: 2});
    });

    test('filled works with custom dice types', () {
      final die = StringDie(['A', 'B']);
      final counts = {'A': 1};
      final filled = counts.filled(die);
      expect(filled, {'A': 1, 'B': 0});
    });
  });
}

enum MyEnum { a, b, c }
