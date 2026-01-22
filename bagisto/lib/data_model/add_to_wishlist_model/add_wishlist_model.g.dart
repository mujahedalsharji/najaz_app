// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddWishListModel _$AddWishListModelFromJson(Map<String, dynamic> json) =>
    AddWishListModel(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$AddWishListModelToJson(AddWishListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : WishlistProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
    };

WishlistProduct _$WishlistProductFromJson(Map<String, dynamic> json) =>
    WishlistProduct(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$WishlistProductToJson(WishlistProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

PriceHtml _$PriceHtmlFromJson(Map<String, dynamic> json) => PriceHtml(
      regular: json['regular'] as String?,
    );

Map<String, dynamic> _$PriceHtmlToJson(PriceHtml instance) => <String, dynamic>{
      'regular': instance.regular,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
    };

BaseImage _$BaseImageFromJson(Map<String, dynamic> json) => BaseImage();

Map<String, dynamic> _$BaseImageToJson(BaseImage instance) =>
    <String, dynamic>{};

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews();

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{};
