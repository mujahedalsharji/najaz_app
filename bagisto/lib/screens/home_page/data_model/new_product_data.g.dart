// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_product_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewProductsModelAdapter extends TypeAdapter<NewProductsModel> {
  @override
  final int typeId = 1;

  @override
  NewProductsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewProductsModel(
      data: (fields[1] as List?)?.cast<NewProducts>(),
    )..paginatorInfo = fields[0] as PaginatorInfo?;
  }

  @override
  void write(BinaryWriter writer, NewProductsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.paginatorInfo)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewProductsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NewProductsAdapter extends TypeAdapter<NewProducts> {
  @override
  final int typeId = 2;

  @override
  NewProducts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewProducts(
      isInSale: fields[27] as bool?,
      type: fields[11] as String?,
      url: fields[12] as String?,
      price: fields[9] as dynamic,
      isNew: fields[13] as bool?,
      id: fields[0] as dynamic,
      productId: fields[1] as dynamic,
      name: fields[4] as String?,
      description: fields[15] as String?,
      shortDescription: fields[16] as String?,
      isInWishlist: fields[17] as bool?,
      priceHtml: fields[20] as PriceHtml?,
      images: (fields[21] as List?)?.cast<Images>(),
      productFlats: (fields[24] as List?)?.cast<ProductFlats>(),
      isSaleable: fields[30] as bool?,
      reviews: (fields[22] as List?)?.cast<Reviews>(),
      groupedProducts: (fields[28] as List?)?.cast<GroupedProducts>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewProducts obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.type)
      ..writeByte(12)
      ..write(obj.url)
      ..writeByte(13)
      ..write(obj.isNew)
      ..writeByte(27)
      ..write(obj.isInSale)
      ..writeByte(15)
      ..write(obj.description)
      ..writeByte(16)
      ..write(obj.shortDescription)
      ..writeByte(17)
      ..write(obj.isInWishlist)
      ..writeByte(20)
      ..write(obj.priceHtml)
      ..writeByte(21)
      ..write(obj.images)
      ..writeByte(22)
      ..write(obj.reviews)
      ..writeByte(24)
      ..write(obj.productFlats)
      ..writeByte(30)
      ..write(obj.isSaleable)
      ..writeByte(28)
      ..write(obj.groupedProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReviewsAdapter extends TypeAdapter<Reviews> {
  @override
  final int typeId = 5;

  @override
  Reviews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reviews(
      rating: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Reviews obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriceHtmlAdapter extends TypeAdapter<PriceHtml> {
  @override
  final int typeId = 20;

  @override
  PriceHtml read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceHtml(
      id: fields[0] as String?,
      type: fields[1] as String?,
      finalPrice: fields[10] as String?,
      formattedFinalPrice: fields[11] as String?,
      formattedRegularPrice: fields[9] as String?,
      priceHtml: fields[6] as String?,
      regularPrice: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PriceHtml obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.priceHtml)
      ..writeByte(8)
      ..write(obj.regularPrice)
      ..writeByte(9)
      ..write(obj.formattedRegularPrice)
      ..writeByte(10)
      ..write(obj.finalPrice)
      ..writeByte(11)
      ..write(obj.formattedFinalPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceHtmlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductFlatsAdapter extends TypeAdapter<ProductFlats> {
  @override
  final int typeId = 8;

  @override
  ProductFlats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductFlats(
      id: fields[0] as String?,
      locale: fields[6] as String?,
      sku: fields[1] as String?,
      name: fields[3] as String?,
      isNew: fields[5] as bool?,
      productNumber: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductFlats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.sku)
      ..writeByte(2)
      ..write(obj.productNumber)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.isNew)
      ..writeByte(6)
      ..write(obj.locale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductFlatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 4;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      id: fields[0] as dynamic,
      type: fields[1] as String?,
      url: fields[3] as String?,
      productId: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewProductsModel _$NewProductsModelFromJson(Map<String, dynamic> json) =>
    NewProductsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NewProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..paginatorInfo = json['paginatorInfo'] == null
        ? null
        : PaginatorInfo.fromJson(json['paginatorInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$NewProductsModelToJson(NewProductsModel instance) =>
    <String, dynamic>{
      'paginatorInfo': instance.paginatorInfo,
      'data': instance.data,
    };

NewProducts _$NewProductsFromJson(Map<String, dynamic> json) => NewProducts(
      isInSale: json['isInSale'] as bool?,
      type: json['type'] as String?,
      url: json['url'] as String?,
      price: json['price'],
      isNew: json['isNew'] as bool?,
      id: json['id'],
      productId: json['productId'],
      name: json['name'] as String?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      isInWishlist: json['isInWishlist'] as bool?,
      priceHtml: json['priceHtml'] == null
          ? null
          : PriceHtml.fromJson(json['priceHtml'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      productFlats: (json['productFlats'] as List<dynamic>?)
          ?.map((e) => ProductFlats.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSaleable: json['isSaleable'] as bool?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleOptions: (json['bundleOptions'] as List<dynamic>?)
          ?.map((e) => BundleOptions.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadableLinks: (json['downloadableLinks'] as List<dynamic>?)
          ?.map((e) => DownloadableLinks.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadableSamples: (json['downloadableSamples'] as List<dynamic>?)
          ?.map((e) => DownloadableSamples.fromJson(e as Map<String, dynamic>))
          .toList(),
      groupedProducts: (json['groupedProducts'] as List<dynamic>?)
          ?.map((e) => GroupedProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      superAttributes: (json['superAttributes'] as List<dynamic>?)
          ?.map((e) => SuperAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalData: (json['additionalData'] as List<dynamic>?)
          ?.map((e) => AdditionalData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cart: json['cart'] == null
          ? null
          : CartModel.fromJson(json['cart'] as Map<String, dynamic>),
      shareURL: json['shareURL'] as String?,
      configurableData: json['configutableData'] == null
          ? null
          : ConfigurableData.fromJson(
              json['configutableData'] as Map<String, dynamic>),
      urlKey: json['urlKey'] as String?,
      averageRating: json['averageRating'] as String?,
      percentageRating: json['percentageRating'],
      customizableOptions: (json['customizableOptions'] as List<dynamic>?)
          ?.map((e) => CustomizableOptions.fromJson(e as Map<String, dynamic>))
          .toList(),
      booking: (json['booking'] as List<dynamic>?)
          ?.map((e) => BookingProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..sku = json['sku'] as String?;

Map<String, dynamic> _$NewProductsToJson(NewProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'sku': instance.sku,
      'price': instance.price,
      'type': instance.type,
      'url': instance.url,
      'isNew': instance.isNew,
      'isInSale': instance.isInSale,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'isInWishlist': instance.isInWishlist,
      'priceHtml': instance.priceHtml,
      'images': instance.images,
      'reviews': instance.reviews,
      'productFlats': instance.productFlats,
      'variants': instance.variants,
      'superAttributes': instance.superAttributes,
      'isSaleable': instance.isSaleable,
      'groupedProducts': instance.groupedProducts,
      'downloadableSamples': instance.downloadableSamples,
      'downloadableLinks': instance.downloadableLinks,
      'bundleOptions': instance.bundleOptions,
      'cart': instance.cart,
      'shareURL': instance.shareURL,
      'configutableData': instance.configurableData,
      'additionalData': instance.additionalData,
      'urlKey': instance.urlKey,
      'averageRating': instance.averageRating,
      'percentageRating': instance.percentageRating,
      'customizableOptions': instance.customizableOptions,
      'booking': instance.booking,
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

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
      id: json['id'] as String?,
      title: json['title'] as String?,
      rating: (json['rating'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      customerName: json['customerName'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'rating': instance.rating,
      'comment': instance.comment,
      'customerName': instance.customerName,
      'createdAt': instance.createdAt,
    };

DownloadableSamples _$DownloadableSamplesFromJson(Map<String, dynamic> json) =>
    DownloadableSamples(
      id: json['id'] as String?,
      fileName: json['fileName'] as String?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DownloadableSamplesToJson(
        DownloadableSamples instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'translations': instance.translations,
    };

PriceHtml _$PriceHtmlFromJson(Map<String, dynamic> json) => PriceHtml(
      id: json['id'] as String?,
      type: json['type'] as String?,
      finalPrice: json['finalPrice'] as String?,
      formattedFinalPrice: json['formattedFinalPrice'] as String?,
      formattedRegularPrice: json['formattedRegularPrice'] as String?,
      priceHtml: json['priceHtml'] as String?,
      regularPrice: json['regularPrice'] as String?,
    );

Map<String, dynamic> _$PriceHtmlToJson(PriceHtml instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'priceHtml': instance.priceHtml,
      'regularPrice': instance.regularPrice,
      'formattedRegularPrice': instance.formattedRegularPrice,
      'finalPrice': instance.finalPrice,
      'formattedFinalPrice': instance.formattedFinalPrice,
    };

ProductFlats _$ProductFlatsFromJson(Map<String, dynamic> json) => ProductFlats(
      id: json['id'] as String?,
      locale: json['locale'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      isNew: json['new'] as bool?,
      productNumber: json['productNumber'] as String?,
    );

Map<String, dynamic> _$ProductFlatsToJson(ProductFlats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'productNumber': instance.productNumber,
      'name': instance.name,
      'new': instance.isNew,
      'locale': instance.locale,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: json['id'],
      type: json['type'] as String?,
      url: json['url'] as String?,
      productId: json['productId'],
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'productId': instance.productId,
    };

AttributeFamily _$AttributeFamilyFromJson(Map<String, dynamic> json) =>
    AttributeFamily(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AttributeFamilyToJson(AttributeFamily instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

AttributeValues _$AttributeValuesFromJson(Map<String, dynamic> json) =>
    AttributeValues(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AttributeValuesToJson(AttributeValues instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SuperAttributes _$SuperAttributesFromJson(Map<String, dynamic> json) =>
    SuperAttributes(
      id: json['id'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$SuperAttributesToJson(SuperAttributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
    };

AdditionalData _$AdditionalDataFromJson(Map<String, dynamic> json) =>
    AdditionalData(
      id: json['id'] as String?,
      label: json['label'] as String?,
      value: json['value'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AdditionalDataToJson(AdditionalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'value': instance.value,
      'type': instance.type,
    };

BundlePrice _$BundlePriceFromJson(Map<String, dynamic> json) => BundlePrice(
      formattedRegularPriceTo: json['formattedRegularPriceTo'] as String?,
    );

Map<String, dynamic> _$BundlePriceToJson(BundlePrice instance) =>
    <String, dynamic>{
      'formattedRegularPriceTo': instance.formattedRegularPriceTo,
    };

ConfigurableData _$ConfigurableDataFromJson(Map<String, dynamic> json) =>
    ConfigurableData(
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      index: (json['index'] as List<dynamic>?)
          ?.map((e) => Index.fromJson(e as Map<String, dynamic>))
          .toList(),
      variantPrices: (json['variantPrices'] as List<dynamic>?)
          ?.map((e) => VariantPrices.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfigurableDataToJson(ConfigurableData instance) =>
    <String, dynamic>{
      'attributes': instance.attributes,
      'index': instance.index,
      'variantPrices': instance.variantPrices,
    };

VariantImages _$VariantImagesFromJson(Map<String, dynamic> json) =>
    VariantImages(
      id: json['id'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantImagesToJson(VariantImages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
    };

VariantPrices _$VariantPricesFromJson(Map<String, dynamic> json) =>
    VariantPrices(
      id: json['id'] as String?,
      regularPrice: json['regularPrice'] == null
          ? null
          : RegularPrice.fromJson(json['regularPrice'] as Map<String, dynamic>),
      finalPrice: json['finalPrice'] == null
          ? null
          : RegularPrice.fromJson(json['finalPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VariantPricesToJson(VariantPrices instance) =>
    <String, dynamic>{
      'id': instance.id,
      'regularPrice': instance.regularPrice,
      'finalPrice': instance.finalPrice,
    };

Index _$IndexFromJson(Map<String, dynamic> json) => Index(
      id: json['id'] as String?,
      attributeOptionIds: (json['attributeOptionIds'] as List<dynamic>?)
          ?.map((e) => AttributeOptionIds.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$IndexToJson(Index instance) => <String, dynamic>{
      'id': instance.id,
      'attributeOptionIds': instance.attributeOptionIds,
    };

AttributeOptionIds _$AttributeOptionIdsFromJson(Map<String, dynamic> json) =>
    AttributeOptionIds(
      attributeId: json['attributeId'] as String?,
      attributeOptionId: json['attributeOptionId'] as String?,
    );

Map<String, dynamic> _$AttributeOptionIdsToJson(AttributeOptionIds instance) =>
    <String, dynamic>{
      'attributeId': instance.attributeId,
      'attributeOptionId': instance.attributeOptionId,
    };

RegularPrice _$RegularPriceFromJson(Map<String, dynamic> json) => RegularPrice(
      price: json['price'],
      formattedPrice: json['formattedPrice'] as String?,
    );

Map<String, dynamic> _$RegularPriceToJson(RegularPrice instance) =>
    <String, dynamic>{
      'price': instance.price,
      'formattedPrice': instance.formattedPrice,
    };

GroupedProducts _$GroupedProductsFromJson(Map<String, dynamic> json) =>
    GroupedProducts(
      id: json['id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      associatedProductId: json['associatedProductId'] as String?,
      associatedProduct: json['associatedProduct'] == null
          ? null
          : AssociatedProduct.fromJson(
              json['associatedProduct'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupedProductsToJson(GroupedProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'associatedProductId': instance.associatedProductId,
      'associatedProduct': instance.associatedProduct,
    };

DownloadableLinks _$DownloadableLinksFromJson(Map<String, dynamic> json) =>
    DownloadableLinks(
      id: json['id'] as String?,
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      sampleFileName: json['sampleFileName'] as String?,
      sampleFileUrl: json['sampleFileUrl'] as String?,
    );

Map<String, dynamic> _$DownloadableLinksToJson(DownloadableLinks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'sampleFileName': instance.sampleFileName,
      'sampleFileUrl': instance.sampleFileUrl,
    };

BundleOptions _$BundleOptionsFromJson(Map<String, dynamic> json) =>
    BundleOptions(
      id: json['id'] as String?,
      type: json['type'] as String?,
      bundleOptionProducts: (json['bundleOptionProducts'] as List<dynamic>?)
          ?.map((e) => BundleOptionProducts.fromJson(e as Map<String, dynamic>))
          .toList(),
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleOptionsToJson(BundleOptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'bundleOptionProducts': instance.bundleOptionProducts,
      'translations': instance.translations,
    };

BundleOptionProducts _$BundleOptionProductsFromJson(
        Map<String, dynamic> json) =>
    BundleOptionProducts(
      id: json['id'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      isDefault: json['isDefault'] as bool?,
      productId: json['productId'] as String?,
      product: json['product'] == null
          ? null
          : NewProducts.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BundleOptionProductsToJson(
        BundleOptionProducts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'isDefault': instance.isDefault,
      'productId': instance.productId,
      'product': instance.product,
    };

AssociatedProduct _$AssociatedProductFromJson(Map<String, dynamic> json) =>
    AssociatedProduct(
      id: json['id'] as String?,
      priceHtml: json['priceHtml'] == null
          ? null
          : PriceHtml.fromJson(json['priceHtml'] as Map<String, dynamic>),
    )..name = json['name'] as String?;

Map<String, dynamic> _$AssociatedProductToJson(AssociatedProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'priceHtml': instance.priceHtml,
    };

CustomizableOptions _$CustomizableOptionsFromJson(Map<String, dynamic> json) =>
    CustomizableOptions(
      id: (json['id'] as num?)?.toInt(),
      label: json['label'],
      type: json['type'],
      isRequired: json['isRequired'] as bool?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      translations: json['translations'] == null
          ? null
          : Translations.fromJson(json['translations'] as Map<String, dynamic>),
      customizableOptionPrices:
          (json['customizableOptionPrices'] as List<dynamic>?)
              ?.map((e) =>
                  CustomizableOptionPrices.fromJson(e as Map<String, dynamic>))
              .toList(),
      supportedFileExtensions: json['supportedFileExtensions'],
      maxCharacters: json['maxCharacters'],
    );

Map<String, dynamic> _$CustomizableOptionsToJson(
        CustomizableOptions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'type': instance.type,
      'isRequired': instance.isRequired,
      'maxCharacters': instance.maxCharacters,
      'supportedFileExtensions': instance.supportedFileExtensions,
      'product': instance.product,
      'translations': instance.translations,
      'customizableOptionPrices': instance.customizableOptionPrices,
    };

CustomizableOptionPrices _$CustomizableOptionPricesFromJson(
        Map<String, dynamic> json) =>
    CustomizableOptionPrices(
      id: (json['id'] as num?)?.toInt(),
      label: json['label'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CustomizableOptionPricesToJson(
        CustomizableOptionPrices instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'price': instance.price,
    };

BookingProduct _$BookingProductFromJson(Map<String, dynamic> json) =>
    BookingProduct(
      id: json['id'] as String?,
      type: json['type'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      location: json['location'] as String?,
      showLocation: json['showLocation'] as bool?,
      availableEveryWeek: json['availableEveryWeek'],
      availableFrom: json['availableFrom'] as String?,
      availableTo: json['availableTo'] as String?,
      productId: json['productId'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      defaultSlot: json['defaultSlot'] == null
          ? null
          : DefaultBookingProductSlots.fromJson(
              json['defaultSlot'] as Map<String, dynamic>),
      appointmentSlot: json['appointmentSlot'] == null
          ? null
          : AppointmentBookingProductSlots.fromJson(
              json['appointmentSlot'] as Map<String, dynamic>),
      eventTickets: (json['eventTickets'] as List<dynamic>?)
          ?.map((e) => EventTicket.fromJson(e as Map<String, dynamic>))
          .toList(),
      rentalSlot: json['rentalSlot'],
      tableSlot: json['tableSlot'] == null
          ? null
          : TableSlot.fromJson(json['tableSlot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingProductToJson(BookingProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'qty': instance.qty,
      'location': instance.location,
      'showLocation': instance.showLocation,
      'availableEveryWeek': instance.availableEveryWeek,
      'availableFrom': instance.availableFrom,
      'availableTo': instance.availableTo,
      'productId': instance.productId,
      'product': instance.product,
      'defaultSlot': instance.defaultSlot,
      'appointmentSlot': instance.appointmentSlot,
      'eventTickets': instance.eventTickets,
      'rentalSlot': instance.rentalSlot,
      'tableSlot': instance.tableSlot,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
    };

DefaultBookingProductSlots _$DefaultBookingProductSlotsFromJson(
        Map<String, dynamic> json) =>
    DefaultBookingProductSlots(
      id: json['id'] as String?,
      bookingType: json['bookingType'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      breakTime: (json['breakTime'] as num?)?.toInt(),
      slotManyDays: (json['slotManyDays'] as List<dynamic>?)
          ?.map((e) => SlotManyDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      slotOneDay: (json['slotOneDay'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SlotOneDay.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$DefaultBookingProductSlotsToJson(
        DefaultBookingProductSlots instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingType': instance.bookingType,
      'duration': instance.duration,
      'breakTime': instance.breakTime,
      'slotManyDays': instance.slotManyDays,
      'slotOneDay': instance.slotOneDay,
    };

AppointmentBookingProductSlots _$AppointmentBookingProductSlotsFromJson(
        Map<String, dynamic> json) =>
    AppointmentBookingProductSlots(
      id: json['id'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      breakTime: (json['breakTime'] as num?)?.toInt(),
      sameSlotAllDays: json['sameSlotAllDays'] as bool?,
      slotManyDays: (json['slotManyDays'] as List<dynamic>?)
          ?.map((e) => SlotManyDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      slotOneDay: (json['slotOneDay'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SlotOneDay.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$AppointmentBookingProductSlotsToJson(
        AppointmentBookingProductSlots instance) =>
    <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'breakTime': instance.breakTime,
      'sameSlotAllDays': instance.sameSlotAllDays,
      'slotManyDays': instance.slotManyDays,
      'slotOneDay': instance.slotOneDay,
    };

BookingDaySlots _$BookingDaySlotsFromJson(Map<String, dynamic> json) =>
    BookingDaySlots(
      id: json['id'] as String?,
      day: json['day'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$BookingDaySlotsToJson(BookingDaySlots instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'from': instance.from,
      'to': instance.to,
    };

EventTicket _$EventTicketFromJson(Map<String, dynamic> json) => EventTicket(
      typename: json['__typename'] as String?,
      id: json['id'] as String?,
      price: (json['price'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      specialPrice: (json['specialPrice'] as num?)?.toInt(),
      specialPriceFrom: json['specialPriceFrom'] == null
          ? null
          : DateTime.parse(json['specialPriceFrom'] as String),
      specialPriceTo: json['specialPriceTo'] == null
          ? null
          : DateTime.parse(json['specialPriceTo'] as String),
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventTicketToJson(EventTicket instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'price': instance.price,
      'qty': instance.qty,
      'name': instance.name,
      'description': instance.description,
      'specialPrice': instance.specialPrice,
      'specialPriceFrom': instance.specialPriceFrom?.toIso8601String(),
      'specialPriceTo': instance.specialPriceTo?.toIso8601String(),
      'translations': instance.translations,
    };

TableSlot _$TableSlotFromJson(Map<String, dynamic> json) => TableSlot(
      id: json['id'] as String?,
      guestLimit: (json['guestLimit'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      breakTime: (json['breakTime'] as num?)?.toInt(),
      preventSchedulingBefore: json['preventSchedulingBefore'] as bool?,
      sameSlotAllDays: json['sameSlotAllDays'] as bool?,
      slotManyDays: (json['slotManyDays'] as List<dynamic>?)
          ?.map((e) => SlotManyDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      slotOneDay: (json['slotOneDay'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SlotOneDay.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$TableSlotToJson(TableSlot instance) => <String, dynamic>{
      'id': instance.id,
      'guestLimit': instance.guestLimit,
      'duration': instance.duration,
      'breakTime': instance.breakTime,
      'preventSchedulingBefore': instance.preventSchedulingBefore,
      'sameSlotAllDays': instance.sameSlotAllDays,
      'slotManyDays': instance.slotManyDays,
      'slotOneDay': instance.slotOneDay,
    };

SlotManyDay _$SlotManyDayFromJson(Map<String, dynamic> json) => SlotManyDay(
      to: json['to'] as String?,
      from: json['from'] as String?,
    );

Map<String, dynamic> _$SlotManyDayToJson(SlotManyDay instance) =>
    <String, dynamic>{
      'to': instance.to,
      'from': instance.from,
    };

SlotOneDay _$SlotOneDayFromJson(Map<String, dynamic> json) => SlotOneDay(
      id: json['id'],
      to: json['to'],
      from: json['from'],
    );

Map<String, dynamic> _$SlotOneDayToJson(SlotOneDay instance) =>
    <String, dynamic>{
      'id': instance.id,
      'to': instance.to,
      'from': instance.from,
    };
