import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

/// A class that represents a die.
///
/// A [Die] has a list of [faces], each of which is of type [T].
@immutable
abstract class Die<T> {
  final List<T> _faces;

  /// Creates a die with the given faces.
  ///
  /// A die must have at least two faces.
  ///
  /// Throws [ArgumentError] if [faces] has fewer than two elements.
  Die(Iterable<T> faces) : _faces = List<T>.unmodifiable(faces) {
    if (_faces.length < 2) {
      throw ArgumentError.value(
        _faces,
        'faces',
        'a die must have at least two faces',
      );
    }
  }

  /// The faces of the die.
  ///
  /// Returns an unmodifiable list.
  List<T> get faces => _faces;

  @override
  int get hashCode => const ListEquality<Object?>().hash(_faces);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Die<T> &&
          const ListEquality<Object?>().equals(_faces, other._faces);

  @override
  String toString() => 'Die(faces: $_faces)';
}
