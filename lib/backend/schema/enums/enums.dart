import 'package:collection/collection.dart';

enum OrderStatus {
  Created,
  Cancelled,
  Completed,
  inProcess,
}

enum PaymentStatus {
  Paid,
  Processing,
  Expecting,
  Failed,
}

enum AssignmentStatus {
  Assigned,
  NotAssigned,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (OrderStatus):
      return OrderStatus.values.deserialize(value) as T?;
    case (PaymentStatus):
      return PaymentStatus.values.deserialize(value) as T?;
    case (AssignmentStatus):
      return AssignmentStatus.values.deserialize(value) as T?;
    default:
      return null;
  }
}
