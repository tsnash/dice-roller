import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class RollResult {
  final List<int> _rolls;
  late final int _totalValue = _rolls.fold(0, (a, b) => a + b);

  RollResult(List<int> rolls) : _rolls = List.unmodifiable(rolls);

  RollResult.unmodifiable(List<int> rolls) : _rolls = List.unmodifiable(rolls);

  factory RollResult.constant(List<int> rolls) =>
      RollResult.unmodifiable(rolls);

  List<int> get values => UnmodifiableListView(_rolls);
  int get totalValue => _totalValue;

  @override
  int get hashCode => const ListEquality<int>().hash(_rolls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RollResult &&
          const ListEquality<int>().equals(_rolls, other._rolls);

  @override
  String toString() => 'RollResult(values: $_rolls, totalValue: $totalValue)';
}
