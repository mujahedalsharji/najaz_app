/*
 * Najaz Mobile App
 * My Service Requests Model
 * 
 * Data models for myServiceRequests GraphQL query.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import '../home_models/home_page_model.dart';

part 'my_service_requests_model.g.dart';

@JsonSerializable()
class MyServiceRequestsModel extends GraphQLBaseModel {
  /// List of service requests
  final List<MyServiceRequestModel>? data;

  /// Pagination information
  @JsonKey(name: 'paginatorInfo')
  final PaginatorInfo? paginatorInfo;

  MyServiceRequestsModel({
    this.data,
    this.paginatorInfo,
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

  factory MyServiceRequestsModel.fromJson(Map<String, dynamic> json) =>
      _$MyServiceRequestsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MyServiceRequestsModelToJson(this);
}

@JsonSerializable()
class MyServiceRequestModel {
  @JsonKey(fromJson: _idFromJson)
  final String? id;

  @JsonKey(name: 'incrementId')
  final String? incrementId;

  @JsonKey(name: 'serviceId', fromJson: _idFromJson)
  final String? serviceId;

  @JsonKey(name: 'citizenId', fromJson: _idFromJson)
  final String? citizenId;

  final String? status;
  final dynamic formData;
  final String? notes;

  @JsonKey(name: 'completedAt')
  final String? completedAt;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  final MyServiceRequestService? service;

  MyServiceRequestModel({
    this.id,
    this.incrementId,
    this.serviceId,
    this.citizenId,
    this.status,
    this.formData,
    this.notes,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  factory MyServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MyServiceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyServiceRequestModelToJson(this);
}

@JsonSerializable()
class MyServiceRequestService {
  final String? name;

  MyServiceRequestService({this.name});

  factory MyServiceRequestService.fromJson(Map<String, dynamic> json) =>
      _$MyServiceRequestServiceFromJson(json);

  Map<String, dynamic> toJson() => _$MyServiceRequestServiceToJson(this);
}

