import 'package:freezed_annotation/freezed_annotation.dart';
part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  factory Customer({
    required String id,
    required String login,
    required String password,
    required String fullName,
    @JsonKey(name: 'completed_order_ids')
    required List<String> completedOrderIds,
    @JsonKey(name: 'future_order_ids')
    required List<String> futureOrderIds,
    @JsonKey(name: 'current_order_ids')
    required List<String> currentOrderIds,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
}