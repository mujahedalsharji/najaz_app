// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      couponCode: json['couponCode'] as String?,
      itemsCount: (json['itemsCount'] as num?)?.toInt(),
      itemsQty: (json['itemsQty'] as num?)?.toInt(),
      taxTotal: json['taxTotal'],
      appliedTaxRates: (json['appliedTaxRates'] as List<dynamic>?)
          ?.map((e) => AppliedTaxRate.fromJson(e as Map<String, dynamic>))
          .toList(),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
      shippingAddress: json['shippingAddress'] == null
          ? null
          : ShippingAddress.fromJson(
              json['shippingAddress'] as Map<String, dynamic>),
      billingAddress: json['billingAddress'] == null
          ? null
          : ShippingAddress.fromJson(
              json['billingAddress'] as Map<String, dynamic>),
      selectedShippingRate: json['selectedShippingRate'] == null
          ? null
          : SelectedShippingRate.fromJson(
              json['selectedShippingRate'] as Map<String, dynamic>),
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      grandTotal: (json['grandTotal'] as num?)?.toDouble(),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'id': instance.id,
      'couponCode': instance.couponCode,
      'itemsCount': instance.itemsCount,
      'itemsQty': instance.itemsQty,
      'grandTotal': instance.grandTotal,
      'taxTotal': instance.taxTotal,
      'formattedPrice': instance.formattedPrice,
      'items': instance.items,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'selectedShippingRate': instance.selectedShippingRate,
      'payment': instance.payment,
      'appliedTaxRates': instance.appliedTaxRates,
    };

AppliedTaxRate _$AppliedTaxRateFromJson(Map<String, dynamic> json) =>
    AppliedTaxRate(
      taxName: json['taxName'] as String,
      totalAmount: json['totalAmount'] as String,
    );

Map<String, dynamic> _$AppliedTaxRateToJson(AppliedTaxRate instance) =>
    <String, dynamic>{
      'taxName': instance.taxName,
      'totalAmount': instance.totalAmount,
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

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['id'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      type: json['type'] as String?,
      name: json['name'] as String?,
      additional: json['additional'],
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'additional': instance.additional,
      'product': instance.product,
      'formattedPrice': instance.formattedPrice,
    };

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    ShippingAddress(
      id: json['id'] as String?,
      address1: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ShippingAddressToJson(ShippingAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address1,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'phone': instance.phone,
    };

SelectedShippingRate _$SelectedShippingRateFromJson(
        Map<String, dynamic> json) =>
    SelectedShippingRate(
      id: json['id'] as String?,
      methodTitle: json['methodTitle'] as String?,
      formattedPrice: json['formattedPrice'] == null
          ? null
          : FormattedPrice.fromJson(
              json['formattedPrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelectedShippingRateToJson(
        SelectedShippingRate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'methodTitle': instance.methodTitle,
      'formattedPrice': instance.formattedPrice,
    };

FormattedPrice _$FormattedPriceFromJson(Map<String, dynamic> json) =>
    FormattedPrice(
      json['grandTotal'] as String?,
      json['subTotal'] as String?,
      json['discountAmount'],
      json['taxAmount'],
      json['shippingAmount'] as String?,
      json['price'],
      json['total'],
      json['taxTotal'],
      json['baseTotal'],
      json['adjustmentFee'] as String?,
      json['adjustmentRefund'] as String?,
    );

Map<String, dynamic> _$FormattedPriceToJson(FormattedPrice instance) =>
    <String, dynamic>{
      'price': instance.price,
      'total': instance.total,
      'baseTotal': instance.baseTotal,
      'discountAmount': instance.discountAmount,
      'taxAmount': instance.taxAmount,
      'grandTotal': instance.grandTotal,
      'subTotal': instance.subTotal,
      'shippingAmount': instance.shippingAmount,
      'taxTotal': instance.taxTotal,
      'adjustmentFee': instance.adjustmentFee,
      'adjustmentRefund': instance.adjustmentRefund,
    };
