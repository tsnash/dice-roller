# dice-roller

A Dart library for simulating dice rolls.

A flexible and extensible Dart library for simulating dice rolls. This package allows you to roll standard dice, or create your own custom dice with any number of sides.

## Getting Started

To use this package, add `dice_roller` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  dice_roller: ^0.0.1
```

Then, run `flutter pub get` to install the package.

## Usage

Here's a simple example of how to use the `dice_roller` package to roll a standard 6-sided die:

```dart
import 'package:dice_roller/dice_roller.dart';

void main() {
  // Create a standard 6-sided die.
  final die = Die(6);

  // Roll the die.
  final rollResult = die.roll();

  // Print the result.
  print('You rolled a ${rollResult.value}');
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
