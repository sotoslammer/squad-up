import 'package:collection/collection.dart' show IterableExtension;
import 'package:uuid/uuid.dart';

var uuid = Uuid();

T? enumFromString<T>(List<T> values, String? value) {
  return values.firstWhereOrNull((v) => v.toString().split('.')[1] == value);
}

String newID() => uuid.v5(Uuid.NAMESPACE_URL, "www.mcpsquadup.com");