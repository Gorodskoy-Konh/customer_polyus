// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Driver _$$_DriverFromJson(Map<String, dynamic> json) => _$_Driver(
      name: json['name'] as String,
      type: json['type'] as String,
      monthHours: json['monthHours'] as int,
      allHours: json['allHours'] as int,
      dailyTransportId: json['dailyTransportId'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_DriverToJson(_$_Driver instance) => <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'monthHours': instance.monthHours,
      'allHours': instance.allHours,
      'dailyTransportId': instance.dailyTransportId,
      'id': instance.id,
    };
