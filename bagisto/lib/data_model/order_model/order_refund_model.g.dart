// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_refund_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRefundModel _$OrderRefundModelFromJson(Map<String, dynamic> json) =>
    OrderRefundModel(
      viewRefunds: (json['data'] as List<dynamic>?)
          ?.map((e) => ViewRefunds.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderRefundModelToJson(OrderRefundModel instance) =>
    <String, dynamic>{
      'data': instance.viewRefunds,
    };

ViewRefunds _$ViewRefundsFromJson(Map<String, dynamic> json) => ViewRefunds(
      id: (json['id'] as num?)?.toInt(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RefundItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewRefundsToJson(ViewRefunds instance) =>
    <String, dynamic>{
      'id': instance.id,
      'formattedPrice': instance.formattedPrice,
      'items': instance.items,
    };

RefundItems _$RefundItemsFromJson(Map<String, dynamic> json) => RefundItems(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RefundItemsToJson(RefundItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'qty': instance.qty,
      'formattedPrice': instance.formattedPrice,
    };
