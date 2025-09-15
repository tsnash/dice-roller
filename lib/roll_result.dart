import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
class RollResult<T> {
  final List<T> _rolls;

  RollResult(Iterable<T> rolls) : _rolls = List.unmodifiable(rolls);

  RollResult.unmodifiable(Iterable<T> rolls)
      : _rolls = List.unmodifiable(rolls);

  factory RollResult.constant(Iterable<T> rolls) =>
      RollResult.unmodifiable(rolls);

  List<T> get values => _rolls;

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
    final isNumeric = _rolls.every((r) => r is num);
    if (!isNumeric) return 'RollResult(values: $_rolls)';
    final total = _rolls.cast<num>().fold<num>(0, (a, b) => a + b);
    return 'RollResult(values: $_rolls, totalValue: $total)';
  }
}
