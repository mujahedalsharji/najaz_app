// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFilterAttribute _$GetFilterAttributeFromJson(Map<String, dynamic> json) =>
    GetFilterAttribute(
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      filterAttributes: json['filterAttributes'] as List<dynamic>?,
      sortOrders: (json['sortOrders'] as List<dynamic>?)
          ?.map((e) => SortOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$GetFilterAttributeToJson(GetFilterAttribute instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'filterAttributes': instance.filterAttributes,
      'sortOrders': instance.sortOrders,
    };

SortOrder _$SortOrderFromJson(Map<String, dynamic> json) => SortOrder(
      key: json['key'] as String?,
      value: json['value'] as String?,
      title: json['title'] as String?,
      order: json['order'] as String?,
      position: json['position'] as String?,
    );

Map<String, dynamic> _$SortOrderToJson(SortOrder instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'title': instance.title,
      'order': instance.order,
      'position': instance.position,
    };

Value _$ValueFromJson(Map<String, dynamic> json) => Value();

Map<String, dynamic> _$ValueToJson(Value instance) => <String, dynamic>{};
