import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// The result of a dice roll.
@immutable
class RollResult<T> {
  final List<T> _rolls;
  late final Map<T, int> _valueCounts = () {
    final counts = <T, int>{};
    for (final roll in _rolls) {
      counts[roll] = (counts[roll] ?? 0) + 1;
    }
    return Map<T, int>.unmodifiable(counts);
  }();

  /// Creates a new [RollResult] with the given rolls.
  ///
  /// The rolls are stored in an unmodifiable list.
  RollResult(Iterable<T> rolls) : _rolls = List<T>.unmodifiable(rolls);

  /// The values of the individual rolls.
  ///
  /// Returns an unmodifiable list.
  List<T> get values => _rolls;

  /// The sum of the values of the rolls.
  ///
  /// Returns `0` if the rolls list is empty.
  ///
  /// Throws an [UnsupportedError] if there are non-numeric rolls.
  num get totalValue {
    if (_rolls.every((r) => r is num)) {
      return _rolls.cast<num>().fold<num>(0, (a, b) => a + b);
    }
    throw UnsupportedError(
        'Cannot calculate totalValue because at least one roll value was not numeric');
  }

  /// A map of the counts of each unique roll value.
  ///
  /// Returns a sparse map where the keys are the unique dice roll
  /// faces and the values are the number of times that face was rolled.
  Map<T, int> get valueCounts => _valueCounts;

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
