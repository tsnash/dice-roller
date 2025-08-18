import 'package:flutter_test/flutter_test.dart';

import 'package:dice_roller/dice_roller.dart';

void main() {
  test('adds one to input values', () {
    expect(roll(), 6);
  });
}
