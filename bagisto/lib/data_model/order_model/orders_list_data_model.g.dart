// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_list_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersListModel _$OrdersListModelFromJson(Map<String, dynamic> json) =>
    OrdersListModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginatorInfo: json['paginatorInfo'] == null
          ? null
          : PaginatorInfo.fromJson(
              json['paginatorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrdersListModelToJson(OrdersListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'paginatorInfo': instance.paginatorInfo,
    };

PaginatorInfo _$PaginatorInfoFromJson(Map<String, dynamic> json) =>
    PaginatorInfo(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      lastPage: (json['lastPage'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginatorInfoToJson(PaginatorInfo instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'lastPage': instance.lastPage,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      incrementId: json['incrementId'] as String?,
      totalQtyOrdered: (json['totalQtyOrdered'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'incrementId': instance.incrementId,
      'status': instance.status,
      'totalQtyOrdered': instance.totalQtyOrdered,
      'createdAt': instance.createdAt,
      'formattedPrice': instance.formattedPrice,
    };

OrderListProduct _$OrderListProductFromJson(Map<String, dynamic> json) =>
    OrderListProduct(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      urlKey: json['urlKey'] as String?,
      price: json['price'],
      formatedPrice: json['formatedPrice'] as String?,
      shortDescription: json['shortDescription'] as String?,
      description: json['description'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseImage: json['baseImage'] == null
          ? null
          : BaseImage.fromJson(json['baseImage'] as Map<String, dynamic>),
      reviews: json['reviews'] == null
          ? null
          : Reviews.fromJson(json['reviews'] as Map<String, dynamic>),
      inStock: json['inStock'] as bool?,
      isSaved: json['isSaved'] as bool?,
      isWishlisted: json['isWishlisted'] as bool?,
      isItemInCart: json['isItemInCart'] as bool?,
      showQuantityChanger: json['showQuantityChanger'] as bool?,
    );

Map<String, dynamic> _$OrderListProductToJson(OrderListProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'type': instance.type,
      'name': instance.name,
      'urlKey': instance.urlKey,
      'price': instance.price,
      'formatedPrice': instance.formatedPrice,
      'shortDescription': instance.shortDescription,
      'description': instance.description,
      'images': instance.images,
      'baseImage': instance.baseImage,
      'reviews': instance.reviews,
      'inStock': instance.inStock,
      'isSaved': instance.isSaved,
      'isWishlisted': instance.isWishlisted,
      'isItemInCart': instance.isItemInCart,
      'showQuantityChanger': instance.showQuantityChanger,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: (json['id'] as num?)?.toInt(),
      path: json['path'] as String?,
      url: json['url'] as String?,
      originalImageUrl: json['originalImageUrl'] as String?,
      smallImageUrl: json['smallImageUrl'] as String?,
      mediumImageUrl: json['mediumImageUrl'] as String?,
      largeImageUrl: json['largeImageUrl'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'url': instance.url,
      'originalImageUrl': instance.originalImageUrl,
      'smallImageUrl': instance.smallImageUrl,
      'mediumImageUrl': instance.mediumImageUrl,
      'largeImageUrl': instance.largeImageUrl,
    };

BaseImage _$BaseImageFromJson(Map<String, dynamic> json) => BaseImage(
      smallImageUrl: json['smallImageUrl'] as String?,
      mediumImageUrl: json['mediumImageUrl'] as String?,
      largeImageUrl: json['largeImageUrl'] as String?,
      originalImageUrl: json['originalImageUrl'] as String?,
    );

Map<String, dynamic> _$BaseImageToJson(BaseImage instance) => <String, dynamic>{
      'smallImageUrl': instance.smallImageUrl,
      'mediumImageUrl': instance.mediumImageUrl,
      'largeImageUrl': instance.largeImageUrl,
      'originalImageUrl': instance.originalImageUrl,
    };

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      total: (json['total'] as num?)?.toInt(),
      totalRating: (json['totalRating'] as num?)?.toInt(),
      averageRating: (json['averageRating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'total': instance.total,
      'totalRating': instance.totalRating,
      'averageRating': instance.averageRating,
    };
