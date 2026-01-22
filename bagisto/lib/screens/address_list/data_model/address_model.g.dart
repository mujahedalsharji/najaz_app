// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      addressData: (json['data'] as List<dynamic>?)
          ?.map((e) => AddressData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..graphqlErrors = json['graphqlErrors'] as String?
      ..status = json['status'] as bool?
      ..message = json['message'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..error = json['error']
      ..countryData = json['countryData'] == null
          ? null
          : CountriesData.fromJson(json['countryData'] as Map<String, dynamic>);

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'graphqlErrors': instance.graphqlErrors,
      'status': instance.status,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'error': instance.error,
      'data': instance.addressData,
      'countryData': instance.countryData,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      companyName: json['companyName'] as String?,
      vatId: json['vatId'] as String?,
      address1: json['address'] as String? ?? '',
      country: json['country'] as String?,
      countryName: json['countryName'] as String?,
      stateName: json['stateName'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      postcode: json['postcode'] as String?,
      phone: json['phone'] as String?,
      isDefault: json['defaultAddress'] as bool? ?? false,
      shippingAddressId: (json['shippingAddressId'] as num?)?.toInt(),
      billingAddressId: (json['billingAddressId'] as num?)?.toInt(),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'companyName': instance.companyName,
      'vatId': instance.vatId,
      'address': instance.address1,
      'country': instance.country,
      'countryName': instance.countryName,
      'stateName': instance.stateName,
      'state': instance.state,
      'city': instance.city,
      'postcode': instance.postcode,
      'phone': instance.phone,
      'defaultAddress': instance.isDefault,
      'billingAddressId': instance.billingAddressId,
      'shippingAddressId': instance.shippingAddressId,
    };
