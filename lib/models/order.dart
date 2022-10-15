import 'package:freezed_annotation/freezed_annotation.dart';
part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  factory Order({
    required String id,
    required String customerId,
    required DateTime begin,
    required DateTime end,
    required String transportId,
    // destination point
    @Default(false) bool isCompleteByDriver,
    @Default(false) bool isCompleteByDispatcher,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
