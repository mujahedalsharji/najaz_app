// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveOrderModel _$SaveOrderModelFromJson(Map<String, dynamic> json) =>
    SaveOrderModel(
      redirectUrl: json['redirectUrl'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$SaveOrderModelToJson(SaveOrderModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'redirectUrl': instance.redirectUrl,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
    )..incrementId = json['incrementId'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
    };
