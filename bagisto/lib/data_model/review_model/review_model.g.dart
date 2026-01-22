// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReviewData.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'paginatorInfo': instance.paginatorInfo,
      'data': instance.data,
    };

PaginatorInfo _$PaginatorInfoFromJson(Map<String, dynamic> json) =>
    PaginatorInfo(
      count: (json['count'] as num?)?.toInt(),
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatorInfoToJson(PaginatorInfo instance) =>
    <String, dynamic>{
      'count': instance.count,
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
      'total': instance.total,
    };

ReviewData _$ReviewDataFromJson(Map<String, dynamic> json) => ReviewData(
      id: json['id'] as String?,
      title: json['title'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      productId: json['productId'] as String?,
      product: json['product'] == null
          ? null
          : ProductData.fromJson(json['product'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..customer = json['customer'] == null
          ? null
          : Customer.fromJson(json['customer'] as Map<String, dynamic>);

Map<String, dynamic> _$ReviewDataToJson(ReviewData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rating': instance.rating,
      'comment': instance.comment,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'productId': instance.productId,
      'product': instance.product,
      'customer': instance.customer,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'] as String?,
      productFlats: (json['productFlats'] as List<dynamic>?)
          ?.map((e) => ProductFlats.fromJson(e as Map<String, dynamic>))
          .toList(),
      urlKey: json['urlKey'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urlKey': instance.urlKey,
      'productFlats': instance.productFlats,
      'images': instance.images,
      'name': instance.name,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'url': instance.url,
    };

ProductFlats _$ProductFlatsFromJson(Map<String, dynamic> json) => ProductFlats(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$ProductFlatsToJson(ProductFlats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'locale': instance.locale,
    };
