import 'package:collection/collection.dart' show IterableExtension;
import 'package:uuid/uuid.dart';

var uuid = Uuid();

T? enumFromString<T>(List<T> values, String? value) {
  return values.firstWhereOrNull((v) => v.toString().split('.')[1] == value);
}

String enumToString(Object? o) => o != null ? o.toString().split('.').last : '';

String newID() => uuid.v5(Uuid.NAMESPACE_URL, "www.mcpsquadup.com");

extension ListExtension<T> on List<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) map) sync* {
    for (var index = 0; index < length; index++) {
      yield map(index, this[index]);
    }
  }
}