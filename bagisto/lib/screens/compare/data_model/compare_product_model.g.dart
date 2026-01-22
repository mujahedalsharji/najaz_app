// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompareProductsData _$CompareProductsDataFromJson(Map<String, dynamic> json) =>
    CompareProductsData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CompareProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$CompareProductsDataToJson(
        CompareProductsData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'data': instance.data,
    };

CompareProducts _$CompareProductsFromJson(Map<String, dynamic> json) =>
    CompareProducts(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompareProductsToJson(CompareProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'product': instance.product,
    };
