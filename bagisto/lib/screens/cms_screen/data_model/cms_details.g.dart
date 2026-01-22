// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CmsPage _$CmsPageFromJson(Map<String, dynamic> json) => CmsPage(
      id: json['id'] as String?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CmsPageToJson(CmsPage instance) => <String, dynamic>{
      'id': instance.id,
      'translations': instance.translations,
    };

Translations _$TranslationsFromJson(Map<String, dynamic> json) => Translations(
      id: json['id'] as String?,
      name: json['name'] as String?,
      htmlContent: json['htmlContent'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$TranslationsToJson(Translations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'htmlContent': instance.htmlContent,
      'locale': instance.locale,
    };
