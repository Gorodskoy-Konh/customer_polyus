// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      begin: DateTime.parse(json['begin'] as String),
      end: DateTime.parse(json['end'] as String),
      transportId: json['transportId'] as String,
      isCompleteByDriver: json['isCompleteByDriver'] as bool? ?? false,
      isCompleteByDispatcher: json['isCompleteByDispatcher'] as bool? ?? false,
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'begin': instance.begin.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'transportId': instance.transportId,
      'isCompleteByDriver': instance.isCompleteByDriver,
      'isCompleteByDispatcher': instance.isCompleteByDispatcher,
    };
