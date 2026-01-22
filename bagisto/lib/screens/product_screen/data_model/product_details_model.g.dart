// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      type: json['type'] as String?,
      sku: json['sku'] as String?,
      isInWishlist: json['isInWishlist'] as bool?,
      isSaleable: json['isSaleable'] as bool?,
      priceHtml: json['priceHtml'] == null
          ? null
          : PriceHtml.fromJson(json['priceHtml'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      averageRating: json['averageRating'] as String?,
      name: json['name'] as String?,
      urlKey: json['urlKey'] as String?,
      description: json['description'] as String?,
    )..customizableOptions = (json['customizableOptions'] as List<dynamic>?)
        ?.map((e) =>
            ProductCustomizableOptions.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'sku': instance.sku,
      'isInWishlist': instance.isInWishlist,
      'isSaleable': instance.isSaleable,
      'priceHtml': instance.priceHtml,
      'images': instance.images,
      'averageRating': instance.averageRating,
      'urlKey': instance.urlKey,
      'description': instance.description,
      'customizableOptions': instance.customizableOptions,
    };

PriceHtml _$PriceHtmlFromJson(Map<String, dynamic> json) => PriceHtml(
      id: json['id'] as String?,
      priceHtml: json['priceHtml'] as String?,
      finalPrice: json['finalPrice'] as String?,
    );

Map<String, dynamic> _$PriceHtmlToJson(PriceHtml instance) => <String, dynamic>{
      'id': instance.id,
      'priceHtml': instance.priceHtml,
      'finalPrice': instance.finalPrice,
    };

ProductCustomizableOptions _$ProductCustomizableOptionsFromJson(
        Map<String, dynamic> json) =>
    ProductCustomizableOptions(
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductCustomizableOptionsToJson(
        ProductCustomizableOptions instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
