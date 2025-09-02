import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

@immutable
class RollResult {
  RollResult(List<int> rolls) : _rolls = List.unmodifiable(rolls);

  RollResult.unmodifiable(List<int> rolls) : _rolls = List.unmodifiable(rolls);

  factory RollResult.constant(List<int> rolls) =>
      RollResult.unmodifiable(rolls);

  final List<int> _rolls;

  List<int> get values => _rolls;

  int get totalValue => _rolls.fold(0, (a, b) => a + b);

  @override
  int get hashCode => const ListEquality<int>().hash(_rolls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RollResult &&
          const ListEquality<int>().equals(_rolls, other._rolls);

  @override
  String toString() => 'RollResult(rolls: $_rolls, total: $totalValue)';
}
