/*
 * Najaz Mobile App
 * Service List Model
 * 
 * This file contains the data model for service list responses.
 * Follows Bagisto's pattern, tailored for Najaz.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
import 'service_model.dart';

part 'service_list_model.g.dart';

/// Service List Model
/// 
/// Contains a list of services returned from GraphQL queries
@JsonSerializable()
class ServiceListModel extends GraphQLBaseModel {
  /// List of services
  final List<ServiceModel>? services;

  /// Total count of services (for pagination)
  @JsonKey(name: 'totalCount')
  final int? totalCount;

  /// Whether there are more services to load
  @JsonKey(name: 'hasMore')
  final bool? hasMore;

  ServiceListModel({
    this.services,
    this.totalCount,
    this.hasMore,
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

  /// Creates a ServiceListModel instance from JSON
  factory ServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceListModelFromJson(json);

  /// Converts ServiceListModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$ServiceListModelToJson(this);
}

