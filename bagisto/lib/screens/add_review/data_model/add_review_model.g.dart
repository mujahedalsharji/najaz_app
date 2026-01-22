// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewModel _$AddReviewModelFromJson(Map<String, dynamic> json) =>
    AddReviewModel(
      review: json['review'] == null
          ? null
          : Review.fromJson(json['review'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$AddReviewModelToJson(AddReviewModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'review': instance.review,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      type: json['type'] as String?,
      attributeFamilyId: json['attributeFamilyId'],
      sku: json['sku'] as String?,
      parentId: json['parentId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      productFlats: (json['productFlats'] as List<dynamic>?)
          ?.map((e) => ProductFlats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'attributeFamilyId': instance.attributeFamilyId,
      'sku': instance.sku,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'productFlats': instance.productFlats,
    };

ProductFlats _$ProductFlatsFromJson(Map<String, dynamic> json) => ProductFlats(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      urlKey: json['urlKey'] as String?,
      featured: json['featured'] as bool?,
      status: json['status'] as bool?,
      visibleIndividually: json['visibleIndividually'] as bool?,
      price: json['price'],
      color: (json['color'] as num?)?.toInt(),
      colorLabel: json['colorLabel'] as String?,
      size: (json['size'] as num?)?.toInt(),
      sizeLabel: json['sizeLabel'] as String?,
      locale: json['locale'] as String?,
      channel: json['channel'] as String?,
      productId: json['productId'] as String?,
      minPrice: json['minPrice'],
      maxPrice: json['maxPrice'],
      metaTitle: json['metaTitle'] as String?,
      metaKeywords: json['metaKeywords'] as String?,
      metaDescription: json['metaDescription'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductFlatsToJson(ProductFlats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'urlKey': instance.urlKey,
      'featured': instance.featured,
      'status': instance.status,
      'visibleIndividually': instance.visibleIndividually,
      'price': instance.price,
      'color': instance.color,
      'colorLabel': instance.colorLabel,
      'size': instance.size,
      'sizeLabel': instance.sizeLabel,
      'locale': instance.locale,
      'channel': instance.channel,
      'productId': instance.productId,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'metaTitle': instance.metaTitle,
      'metaKeywords': instance.metaKeywords,
      'metaDescription': instance.metaDescription,
      'width': instance.width,
      'height': instance.height,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
