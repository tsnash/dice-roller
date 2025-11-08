import 'package:dice_roller/dice_roller.dart';

void main() {
  // default dice example
  print('\nSimulating 5 D&D-style attack rolls without bonuses or damage calculation:');
  print('Note: seeded to produce hit, miss, critical hit, and critical miss outcomes.');
  final attackRoller = DiceRoller().seed(30898).withDie(TwentySidedDie());
  const criticalMiss = 1;
  const threat = 20;
  const hit = 10;
  const totalAttacks = 5;

  for (int i = 0; i < totalAttacks; i++) {
    final attackRoll = attackRoller.roll().totalValue as int;
    switch (attackRoll) {
      case criticalMiss:
        print('critical miss');
        break;
      case threat:
        // D&D-style confirmation roll to determine if threat becomes critical hit
        final confirm = attackRoller.roll().totalValue as int;
        confirm < hit ? print('hit') : print('critical hit');
        break;
      default:
        attackRoll < hit ? print('miss') : print('hit');
    }
  }

  // enum die example
  print('\nSimulating Catan dice game rolls attempting to build a road and a settlement within a single turn:');
  print('Note: seeded to produce successful build attempt on last roll of turn.');
  final catanDiceGameDie = EnumDie(CatanDieFace.values);
  final catanDiceRoller =
      DiceRoller().seed(173).withDiceCount(6).withDie(catanDiceGameDie);
  const maxAttempts = 3;
  var attempt = 0;
  var built = false;

  while (attempt < maxAttempts) {
    attempt++;
    final roll = catanDiceRoller.roll().values;
    var lumber = 0;
    var brick = 0;
    var wool = 0;
    var grain = 0;
    for (final face in roll) {
      switch (face) {
        case CatanDieFace.brick:
          brick++;
          break;
        case CatanDieFace.lumber:
          lumber++;
          break;
        case CatanDieFace.wool:
          wool++;
          break;
        case CatanDieFace.grain:
          grain++;
          break;
        default:
      }
    }
    if (lumber > 1 && brick > 1 && wool > 0 && grain > 0) {
      print('could build a road and a settlement this roll');
      built = true;
      break;
    }
    print('could not build a road and a settlement this roll');
  }
  built
      ? print('built road and settlement on roll $attempt')
      : print('had to build something else this turn');

  // int die example - clue carnival dice 4, 5, 5, 5, 6, 6
  print('\nSimulating 3 rolls of Clue Carnival: The Case of the Missing Prizes die:');
  print('Note: seeded to produce all 3 distinct movement possibilities.');
  final clueCarnivalDie = IntDie([4, 5, 5, 5, 6, 6]);
  final clueCarnivalRoller = DiceRoller().seed(14).withDie(clueCarnivalDie);

  for (int i = 0; i < 3; i++) {
    print('move ${clueCarnivalRoller.roll().totalValue} spaces');
  }

  // string die example
  print('\nSimulating 5 rolls of Super Mario Party Bowser die:');
  print('Note: outcomes include both movement and non-movement results.');
  final superMarioPartyBowserDie =
      StringDie(['-3 coins', '-3 coins', '1', '8', '9', '10']);
  final superMarioPartyBowserRoller =
      DiceRoller().withDie(superMarioPartyBowserDie);
  for (int i = 0; i < 5; i++) {
    final result = superMarioPartyBowserRoller.roll().values.first;
    switch (result) {
      case '-3 coins':
        print('lose 3 coins');
        break;
      case '1':
        print('move 1 space');
        break;
      default:
        print('move $result spaces');
    }
  }
}

enum CatanDieFace { brick, lumber, wool, grain, ore, gold }
