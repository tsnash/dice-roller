import 'package:flutter_test/flutter_test.dart';

import 'package:dice_roller/dice_roller.dart';

void main() {
  test('roll returns 6', () {
    expect(roll(), 6);
  });
}
