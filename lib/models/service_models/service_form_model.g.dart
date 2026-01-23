// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_form_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceFormModel _$ServiceFormModelFromJson(Map<String, dynamic> json) =>
    ServiceFormModel(
      id: ServiceFormModel._idFromJson(json['id']),
      name: json['name'] as String?,
      description: json['description'] as String?,
      baseImage: json['baseImage'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ServiceImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      form: json['form'] == null
          ? null
          : ServiceForm.fromJson(json['form'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      graphqlErrors: json['graphqlErrors'] as String?,
    );

Map<String, dynamic> _$ServiceFormModelToJson(ServiceFormModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'baseImage': instance.baseImage,
      'images': instance.images,
      'form': instance.form,
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'graphqlErrors': instance.graphqlErrors,
    };

ServiceImage _$ServiceImageFromJson(Map<String, dynamic> json) => ServiceImage(
      id: ServiceFormModel._idFromJson(json['id']),
      type: json['type'] as String?,
      path: json['path'] as String?,
      url: json['url'] as String?,
      position: json['position'] as int?,
      serviceId: ServiceFormModel._idFromJson(json['serviceId']),
    );

Map<String, dynamic> _$ServiceImageToJson(ServiceImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'path': instance.path,
      'url': instance.url,
      'position': instance.position,
      'serviceId': instance.serviceId,
    };

ServiceForm _$ServiceFormFromJson(Map<String, dynamic> json) => ServiceForm(
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => ServiceFormGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceFormToJson(ServiceForm instance) =>
    <String, dynamic>{
      'groups': instance.groups,
    };

ServiceFormGroup _$ServiceFormGroupFromJson(Map<String, dynamic> json) =>
    ServiceFormGroup(
      code: json['code'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      isNotifiable: json['isNotifiable'] as bool?,
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => ServiceFormField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceFormGroupToJson(ServiceFormGroup instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'description': instance.description,
      'isNotifiable': instance.isNotifiable,
      'fields': instance.fields,
    };

ServiceFormField _$ServiceFormFieldFromJson(Map<String, dynamic> json) =>
    ServiceFormField(
      code: json['code'] as String?,
      label: json['label'] as String?,
      type: json['type'] as String?,
      isRequired: json['isRequired'] as bool?,
      defaultValue: json['defaultValue'] as String?,
      validationRules: json['validationRules'],
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ServiceFormOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceFormFieldToJson(ServiceFormField instance) =>
    <String, dynamic>{
      'code': instance.code,
      'label': instance.label,
      'type': instance.type,
      'isRequired': instance.isRequired,
      'defaultValue': instance.defaultValue,
      'validationRules': instance.validationRules,
      'options': instance.options,
    };

ServiceFormOption _$ServiceFormOptionFromJson(Map<String, dynamic> json) =>
    ServiceFormOption(
      value: json['value'] as String?,
      label: json['label'] as String?,
    );

Map<String, dynamic> _$ServiceFormOptionToJson(ServiceFormOption instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
    };

