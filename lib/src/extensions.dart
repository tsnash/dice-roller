import 'die.dart';

extension MapUtils<T> on Map<T, int> {
  Map<T, int> filled(final Die<T> die) {
    final filledMap = <T, int>{};
    for (final face in die.faces) {
      filledMap[face] = this[face] ?? 0;
    }
    return filledMap;
  }
}
