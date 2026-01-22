// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_customization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeCustomDataModel _$ThemeCustomDataModelFromJson(
        Map<String, dynamic> json) =>
    ThemeCustomDataModel(
      themeCustomization: (json['data'] as List<dynamic>?)
          ?.map((e) => ThemeCustomization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ThemeCustomDataModelToJson(
        ThemeCustomDataModel instance) =>
    <String, dynamic>{
      'data': instance.themeCustomization,
    };

ThemeCustomization _$ThemeCustomizationFromJson(Map<String, dynamic> json) =>
    ThemeCustomization(
      id: json['id'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      translations: (json['translations'] as List<dynamic>?)
          ?.map((e) => Translations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ThemeCustomizationToJson(ThemeCustomization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'translations': instance.translations,
    };

Translations _$TranslationsFromJson(Map<String, dynamic> json) => Translations(
      id: json['id'] as String?,
      options: json['options'] == null
          ? null
          : Options.fromJson(json['options'] as Map<String, dynamic>),
      localeCode: json['localeCode'] as String?,
    );

Map<String, dynamic> _$TranslationsToJson(Translations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'localeCode': instance.localeCode,
      'options': instance.options,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      css: json['css'] as String?,
      html: json['html'] as String?,
      title: json['title'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters: (json['filters'] as List<dynamic>?)
          ?.map((e) => Filters.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..services = (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..links = (json['links'] as List<dynamic>?)
          ?.map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..column1 = (json['column_1'] as List<dynamic>?)
          ?.map((e) => ColumnModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..column2 = (json['column_2'] as List<dynamic>?)
          ?.map((e) => ColumnModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..column3 = (json['column_3'] as List<dynamic>?)
          ?.map((e) => ColumnModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'css': instance.css,
      'html': instance.html,
      'title': instance.title,
      'images': instance.images,
      'filters': instance.filters,
      'services': instance.services,
      'links': instance.links,
      'column_1': instance.column1,
      'column_2': instance.column2,
      'column_3': instance.column3,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      serviceIcon: json['serviceIcon'] as String?,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'serviceIcon': instance.serviceIcon,
    };

LinkModel _$LinkModelFromJson(Map<String, dynamic> json) => LinkModel(
      url: json['url'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LinkModelToJson(LinkModel instance) => <String, dynamic>{
      'url': instance.url,
      'slug': instance.slug,
      'type': instance.type,
      'id': instance.id,
    };

ColumnModel _$ColumnModelFromJson(Map<String, dynamic> json) => ColumnModel(
      url: json['url'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ColumnModelToJson(ColumnModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

Filters _$FiltersFromJson(Map<String, dynamic> json) => Filters(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$FiltersToJson(Filters instance) => <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
