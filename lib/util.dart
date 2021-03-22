import 'package:uuid/uuid.dart';

var uuid = Uuid();

T enumFromString<T>(List<T> values, String value) {
  return values.firstWhere((v) => v.toString().split('.')[1] == value,
      orElse: () => null);
}

String newID() => uuid.v5(Uuid.NAMESPACE_URL, "www.mcpsquadup.com");