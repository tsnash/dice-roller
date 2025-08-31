class RollResult {
  const RollResult(this.rolls);

  final List<int> rolls;

  int get total => rolls.fold(0, (a, b) => a + b);
}
