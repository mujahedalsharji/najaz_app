// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShipmentModel _$ShipmentModelFromJson(Map<String, dynamic> json) =>
    ShipmentModel(
      viewShipments: (json['data'] as List<dynamic>?)
          ?.map((e) => ViewShipments.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShipmentModelToJson(ShipmentModel instance) =>
    <String, dynamic>{
      'data': instance.viewShipments,
    };

ViewShipments _$ViewShipmentsFromJson(Map<String, dynamic> json) =>
    ViewShipments(
      id: (json['id'] as num?)?.toInt(),
      trackNumber: json['trackNumber'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewShipmentsToJson(ViewShipments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'trackNumber': instance.trackNumber,
      'items': instance.items,
    };

ItemsModel _$ItemsModelFromJson(Map<String, dynamic> json) => ItemsModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemsModelToJson(ItemsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'qty': instance.qty,
    };
