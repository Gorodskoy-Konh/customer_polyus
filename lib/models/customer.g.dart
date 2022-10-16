// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Customer _$$_CustomerFromJson(Map<String, dynamic> json) => _$_Customer(
      id: json['id'] as String,
      login: json['login'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      completedOrderIds: (json['completed_order_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      futureOrderIds: (json['future_order_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      currentOrderIds: (json['current_order_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_CustomerToJson(_$_Customer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'password': instance.password,
      'fullName': instance.fullName,
      'completed_order_ids': instance.completedOrderIds,
      'future_order_ids': instance.futureOrderIds,
      'current_order_ids': instance.currentOrderIds,
    };
