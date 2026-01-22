// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadable_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadableProductModel _$DownloadableProductModelFromJson(
        Map<String, dynamic> json) =>
    DownloadableProductModel(
      downloadableLinkPurchases: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              DownloadableLinkPurchases.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$DownloadableProductModelToJson(
        DownloadableProductModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'data': instance.downloadableLinkPurchases,
      'paginatorInfo': instance.paginatorInfo,
    };

DownloadableLinkPurchases _$DownloadableLinkPurchasesFromJson(
        Map<String, dynamic> json) =>
    DownloadableLinkPurchases(
      id: json['id'] as String?,
      productName: json['productName'] as String?,
      downloadBought: (json['downloadBought'] as num?)?.toInt(),
      downloadUsed: (json['downloadUsed'] as num?)?.toInt(),
      orderId: json['orderId'] as String?,
      createdAt: json['createdAt'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
      orderItem: json['orderItem'] == null
          ? null
          : OrderItem.fromJson(json['orderItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DownloadableLinkPurchasesToJson(
        DownloadableLinkPurchases instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'downloadBought': instance.downloadBought,
      'downloadUsed': instance.downloadUsed,
      'orderId': instance.orderId,
      'createdAt': instance.createdAt,
      'order': instance.order,
      'orderItem': instance.orderItem,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String?,
      name: json['name'] as String?,
      product: json['product'] == null
          ? null
          : NewProducts.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product': instance.product,
    };
