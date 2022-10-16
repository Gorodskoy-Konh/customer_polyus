
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/strings.dart';

enum OrderStatus {
  complete(kComplete),
  confirmed_by_driver(kConfirmedByDriver),
  in_progress(kInProgress),
  driver_is_defined(kDriverIsDefined),
  driver_is_not_defined(kDriverIsNotDefined),
  processing(kProcessing);

  const OrderStatus(this.description);
  final String description;
}