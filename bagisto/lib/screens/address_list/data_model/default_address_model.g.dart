// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'default_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetDefaultAddress _$SetDefaultAddressFromJson(Map<String, dynamic> json) =>
    SetDefaultAddress(
      address: json['address'] == null
          ? null
          : AddressData.fromJson(json['address'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error'];

Map<String, dynamic> _$SetDefaultAddressToJson(SetDefaultAddress instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'address': instance.address,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      id: json['id'] as String?,
      addressType: json['addressType'] as String?,
      parentAddressId: json['parentAddressId'],
      customerId: json['customerId'] as String?,
      cartId: json['cartId'],
      orderId: json['orderId'],
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'],
      companyName: json['companyName'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postcode: json['postcode'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      vatId: json['vatId'] as String?,
      defaultAddress: json['defaultAddress'] as bool?,
      useForShipping: json['useForShipping'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'addressType': instance.addressType,
      'parentAddressId': instance.parentAddressId,
      'customerId': instance.customerId,
      'cartId': instance.cartId,
      'orderId': instance.orderId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'companyName': instance.companyName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postcode': instance.postcode,
      'email': instance.email,
      'phone': instance.phone,
      'vatId': instance.vatId,
      'defaultAddress': instance.defaultAddress,
      'useForShipping': instance.useForShipping,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
