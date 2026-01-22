// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_save_shipping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
          ?.map((e) => PaymentMethodsList.fromJson(e as Map<String, dynamic>))
          .toList(),
      cart: json['cart'] == null
          ? null
          : CartModel.fromJson(json['cart'] as Map<String, dynamic>),
    )
      ..success = json['success'] as String?
      ..responseStatus = json['responseStatus'] as bool?;

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseStatus': instance.responseStatus,
      'paymentMethods': instance.paymentMethods,
      'cart': instance.cart,
    };

PaymentMethodsList _$PaymentMethodsListFromJson(Map<String, dynamic> json) =>
    PaymentMethodsList(
      method: json['method'] as String?,
      methodTitle: json['methodTitle'] as String?,
    );

Map<String, dynamic> _$PaymentMethodsListToJson(PaymentMethodsList instance) =>
    <String, dynamic>{
      'method': instance.method,
      'methodTitle': instance.methodTitle,
    };
