import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class RollResult<T> {
  final List<T> _rolls;

  RollResult(List<T> rolls) : _rolls = List.unmodifiable(rolls);

  RollResult.unmodifiable(List<T> rolls) : _rolls = List.unmodifiable(rolls);

  factory RollResult.constant(List<T> rolls) =>
      RollResult.unmodifiable(rolls);

  List<T> get values => UnmodifiableListView(_rolls);

  num get totalValue {
    if (_rolls.every((r) => r is num)) {
      return _rolls.cast<num>().fold(0, (a, b) => a + b);
    }
    throw UnsupportedError(
        'Cannot calculate totalValue for non-numeric type');
  }

  @override
  int get hashCode => const ListEquality<Object?>().hash(_rolls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RollResult &&
          const ListEquality<Object?>().equals(_rolls, other._rolls);

  @override
  String toString() {
    if (_rolls.every((r) => r is num)) {
      try {
        return 'RollResult(values: $_rolls, totalValue: $totalValue)';
      } on UnsupportedError {
        return 'RollResult(values: $_rolls)';
      }
    }
    return 'RollResult(values: $_rolls)';
  }
}
