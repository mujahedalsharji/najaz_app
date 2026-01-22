// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_invoices_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoicesModel _$InvoicesModelFromJson(Map<String, dynamic> json) =>
    InvoicesModel(
      viewInvoices: (json['data'] as List<dynamic>?)
          ?.map((e) => ViewInvoices.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoicesModelToJson(InvoicesModel instance) =>
    <String, dynamic>{
      'data': instance.viewInvoices,
    };

ViewInvoices _$ViewInvoicesFromJson(Map<String, dynamic> json) => ViewInvoices(
      id: (json['id'] as num?)?.toInt(),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InvoicesItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ViewInvoicesToJson(ViewInvoices instance) =>
    <String, dynamic>{
      'id': instance.id,
      'items': instance.items,
      'formattedPrice': instance.formattedPrice,
    };

InvoicesItems _$InvoicesItemsFromJson(Map<String, dynamic> json) =>
    InvoicesItems(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoicesItemsToJson(InvoicesItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'qty': instance.qty,
      'formattedPrice': instance.formattedPrice,
    };
