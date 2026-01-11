import 'die.dart';

/// Utility extensions for [Map]s containing roll counts.
extension MapUtils<T> on Map<T, int> {
  /// Returns a new map containing all faces of [die] as keys.
  ///
  /// If a face is present in this map, its value is preserved.
  /// If a face is missing from this map, it is added with a value of `0`.
  ///
  /// This is useful for converting a sparse map of roll counts into a dense map
  /// that includes zero counts for faces that were not rolled.
  Map<T, int> filled(final Die<T> die) {
    final filledMap = <T, int>{};
    for (final face in die.faces) {
      filledMap[face] = this[face] ?? 0;
    }
    return filledMap;
  }
}
