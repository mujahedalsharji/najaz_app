// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
      id: (json['id'] as num?)?.toInt(),
      incrementId: json['incrementId'] as String?,
      shippingTitle: json['shippingTitle'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      billingAddress: json['billingAddress'] == null
          ? null
          : BillingAddress.fromJson(
              json['billingAddress'] as Map<String, dynamic>),
      shippingAddress: json['shippingAddress'] == null
          ? null
          : BillingAddress.fromJson(
              json['shippingAddress'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    )
      ..success = json['success'] as String?
      ..responseStatus = json['responseStatus'] as bool?;

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'success': instance.success,
      'responseStatus': instance.responseStatus,
      'formattedPrice': instance.formattedPrice,
      'id': instance.id,
      'incrementId': instance.incrementId,
      'status': instance.status,
      'shippingTitle': instance.shippingTitle,
      'createdAt': instance.createdAt,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'items': instance.items,
      'payment': instance.payment,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String?,
      method: json['method'] as String?,
      methodTitle: json['methodTitle'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'methodTitle': instance.methodTitle,
    };

BillingAddress _$BillingAddressFromJson(Map<String, dynamic> json) =>
    BillingAddress(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      companyName: json['companyName'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
    )..address1 = json['address'] as String?;

Map<String, dynamic> _$BillingAddressToJson(BillingAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'companyName': instance.companyName,
      'address': instance.address1,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'phone': instance.phone,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      qtyOrdered: (json['qtyOrdered'] as num?)?.toInt(),
      qtyShipped: (json['qtyShipped'] as num?)?.toInt(),
      qtyInvoiced: (json['qtyInvoiced'] as num?)?.toInt(),
      qtyCanceled: (json['qtyCanceled'] as num?)?.toInt(),
      qtyRefunded: (json['qtyRefunded'] as num?)?.toInt(),
      product: json['product'] == null
          ? null
          : OrderProduct.fromJson(json['product'] as Map<String, dynamic>),
      additional: json['additional'],
    )..formattedPrice = json['formattedPrice'] == null
        ? null
        : FormattedPrice.fromJson(
            json['formattedPrice'] as Map<String, dynamic>);

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'type': instance.type,
      'name': instance.name,
      'qtyOrdered': instance.qtyOrdered,
      'qtyShipped': instance.qtyShipped,
      'qtyInvoiced': instance.qtyInvoiced,
      'qtyCanceled': instance.qtyCanceled,
      'qtyRefunded': instance.qtyRefunded,
      'product': instance.product,
      'formattedPrice': instance.formattedPrice,
      'additional': instance.additional,
    };

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      id: json['id'] as String?,
      sku: json['sku'] as String?,
    )..images = (json['images'] as List<dynamic>?)
        ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'images': instance.images,
    };

SuperAttributes _$SuperAttributesFromJson(Map<String, dynamic> json) =>
    SuperAttributes();

Map<String, dynamic> _$SuperAttributesToJson(SuperAttributes instance) =>
    <String, dynamic>{};

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'id': instance.id,
    };
