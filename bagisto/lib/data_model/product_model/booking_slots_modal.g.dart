// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_slots_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingSlot _$BookingSlotFromJson(Map<String, dynamic> json) => BookingSlot(
      from: json['from'] as String?,
      to: json['to'] as String?,
      fromTimestamp: json['fromTimestamp'] as String?,
      toTimestamp: json['toTimestamp'] as String?,
      qty: json['qty'] as bool?,
    );

Map<String, dynamic> _$BookingSlotToJson(BookingSlot instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'fromTimestamp': instance.fromTimestamp,
      'toTimestamp': instance.toTimestamp,
      'qty': instance.qty,
    };

SlotGroup _$SlotGroupFromJson(Map<String, dynamic> json) => SlotGroup(
      from: json['from'] as String?,
      to: json['to'] as String?,
      timestamp: json['timestamp'] as String?,
      qty: json['qty'] as bool?,
      time: json['time'] as String?,
      slots: (json['slots'] as List<dynamic>?)
          ?.map((e) => BookingSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlotGroupToJson(SlotGroup instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'timestamp': instance.timestamp,
      'qty': instance.qty,
      'time': instance.time,
      'slots': instance.slots,
    };

BookingSlotsData _$BookingSlotsDataFromJson(Map<String, dynamic> json) =>
    BookingSlotsData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SlotGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      responseStatus: json['responseStatus'] as bool?,
    );

Map<String, dynamic> _$BookingSlotsDataToJson(BookingSlotsData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'responseStatus': instance.responseStatus,
    };
