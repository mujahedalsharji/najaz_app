/*
 * Najaz Mobile App
 * Service Form Model
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';

part 'service_form_model.g.dart';

@JsonSerializable()
class ServiceFormModel extends GraphQLBaseModel {
  @JsonKey(fromJson: _idFromJson)
  final String? id;
  final String? name;
  final String? description;
  final String? baseImage;
  final List<ServiceImage>? images;
  final ServiceForm? form;

  ServiceFormModel({
    this.id,
    this.name,
    this.description,
    this.baseImage,
    this.images,
    this.form,
    bool? success,
    bool? status,
    String? message,
    String? graphqlErrors,
  }) : super(
          success: success,
          status: status,
          message: message,
          graphqlErrors: graphqlErrors,
        );

  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  factory ServiceFormModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceFormModelToJson(this);
}

@JsonSerializable()
class ServiceImage {
  @JsonKey(fromJson: ServiceFormModel._idFromJson)
  final String? id;
  final String? type;
  final String? path;
  final String? url;
  final int? position;
  @JsonKey(fromJson: ServiceFormModel._idFromJson)
  final String? serviceId;

  ServiceImage({
    this.id,
    this.type,
    this.path,
    this.url,
    this.position,
    this.serviceId,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) =>
      _$ServiceImageFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceImageToJson(this);
}

@JsonSerializable()
class ServiceForm {
  final List<ServiceFormGroup>? groups;

  ServiceForm({this.groups});

  factory ServiceForm.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFormToJson(this);
}

@JsonSerializable()
class ServiceFormGroup {
  final String? code;
  final String? label;
  final String? description;
  final bool? isNotifiable;
  final List<ServiceFormField>? fields;

  ServiceFormGroup({
    this.code,
    this.label,
    this.description,
    this.isNotifiable,
    this.fields,
  });

  factory ServiceFormGroup.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFormGroupToJson(this);
}

@JsonSerializable()
class ServiceFormField {
  final String? code;
  final String? label;
  final String? type;
  final bool? isRequired;
  final String? defaultValue;
  final dynamic validationRules;
  final List<ServiceFormOption>? options;

  ServiceFormField({
    this.code,
    this.label,
    this.type,
    this.isRequired,
    this.defaultValue,
    this.validationRules,
    this.options,
  });

  factory ServiceFormField.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormFieldFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFormFieldToJson(this);
}

@JsonSerializable()
class ServiceFormOption {
  final String? value;
  final String? label;

  ServiceFormOption({this.value, this.label});

  factory ServiceFormOption.fromJson(Map<String, dynamic> json) =>
      _$ServiceFormOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceFormOptionToJson(this);
}

