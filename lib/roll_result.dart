import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// The result of a dice roll.
@immutable
class RollResult<T> {
  final List<T> _rolls;

  /// Creates a new [RollResult] with the given rolls.
  RollResult(Iterable<T> rolls) : _rolls = List.unmodifiable(rolls);

  /// Creates a new [RollResult] with the given rolls.
  ///
  /// This is the same as the default constructor.
  RollResult.unmodifiable(Iterable<T> rolls)
      : _rolls = List.unmodifiable(rolls);

  /// Creates a new constant [RollResult] with the given rolls.
  factory RollResult.constant(Iterable<T> rolls) =>
      RollResult.unmodifiable(rolls);

  /// The values of the individual rolls.
  List<T> get values => _rolls;

  /// The sum of the values of the rolls.
  ///
  /// Throws an [UnsupportedError] if the rolls are not numeric.
  num get totalValue {
    if (_rolls.every((r) => r is num)) {
      return _rolls.cast<num>().fold<num>(0, (a, b) => a + b);
    }
    throw UnsupportedError(
        'Cannot calculate totalValue for non-numeric type (T=${T.toString()})');
  }

  @override
  int get hashCode => const ListEquality<Object?>().hash(_rolls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RollResult<T> &&
          const ListEquality<Object?>().equals(_rolls, other._rolls);

  @override
  String toString() {
    try {
      final total = totalValue;
      return 'RollResult(values: $_rolls, totalValue: $total)';
    } on UnsupportedError {
      return 'RollResult(values: $_rolls)';
    }
  }
}
