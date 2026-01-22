// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyLanguageList _$CurrencyLanguageListFromJson(
        Map<String, dynamic> json) =>
    CurrencyLanguageList(
      locales: (json['locales'] as List<dynamic>?)
          ?.map((e) => Locales.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((e) => Currencies.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseCurrency: json['baseCurrency'] == null
          ? null
          : Currencies.fromJson(json['baseCurrency'] as Map<String, dynamic>),
      rootCategoryId: (json['rootCategoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CurrencyLanguageListToJson(
        CurrencyLanguageList instance) =>
    <String, dynamic>{
      'locales': instance.locales,
      'currencies': instance.currencies,
      'baseCurrency': instance.baseCurrency,
      'id': instance.id,
      'rootCategoryId': instance.rootCategoryId,
    };

Locales _$LocalesFromJson(Map<String, dynamic> json) => Locales(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$LocalesToJson(Locales instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };

Currencies _$CurrenciesFromJson(Map<String, dynamic> json) => Currencies(
      id: json['id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CurrenciesToJson(Currencies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
    };
