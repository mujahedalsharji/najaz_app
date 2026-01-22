// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoModel _$AccountInfoModelFromJson(Map<String, dynamic> json) =>
    AccountInfoModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      phone: json['phone'] as String?,
      subscribedToNewsLetter: json['subscribedToNewsLetter'] as bool?,
    );

Map<String, dynamic> _$AccountInfoModelToJson(AccountInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'imageUrl': instance.imageUrl,
      'dateOfBirth': instance.dateOfBirth,
      'phone': instance.phone,
      'subscribedToNewsLetter': instance.subscribedToNewsLetter,
    };
