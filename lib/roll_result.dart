import 'package:collection/collection.dart';

class RollResult {
  RollResult(List<int> rolls) : rolls = List.unmodifiable(rolls);

  const RollResult.constant(this.rolls);

  RollResult.unmodifiable(List<int> rolls) : rolls = List.unmodifiable(rolls);

  final List<int> rolls;

  int get total => rolls.fold(0, (a, b) => a + b);

  @override
  int get hashCode => const ListEquality<int>().hash(rolls);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RollResult &&
          const ListEquality<int>().equals(rolls, other.rolls);

  @override
  String toString() => 'RollResult(rolls: $rolls, total: $total)';
}
