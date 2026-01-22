/*
 * Najaz Mobile App
 * Home Page Model
 * 
 * This file contains the data model for home page GraphQL query response.
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_models/graphql_base_model.dart';
part 'home_page_model.g.dart';

/// Converter for identity verification status (handles bool and String)
class IdentityVerificationStatusConverter
    implements JsonConverter<String?, dynamic> {
  const IdentityVerificationStatusConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is bool) {
      // Convert boolean to string status
      return json ? 'VERIFIED' : 'PENDING';
    }
    if (json is String) {
      return json;
    }
    // Try to convert to string if it's another type
    return json.toString().toUpperCase();
  }

  @override
  dynamic toJson(String? object) {
    return object;
  }
}

/// Home Page Model
/// 
/// Contains all data needed for the home page from GraphQL query
@JsonSerializable()
class HomePageModel extends GraphQLBaseModel {
  /// Citizen information
  final CitizenHomeData? citizen;

  /// Unread notifications count
  @JsonKey(name: 'unreadNotificationsCount')
  final int? unreadNotificationsCount;

  /// Service requests list
  @JsonKey(name: 'serviceRequests')
  final ServiceRequestListModel? serviceRequests;

  /// Services list
  @JsonKey(name: 'services')
  final ServiceHomeListModel? services;

  HomePageModel({
    this.citizen,
    this.unreadNotificationsCount,
    this.serviceRequests,
    this.services,
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

  /// Creates a HomePageModel instance from JSON
  factory HomePageModel.fromJson(Map<String, dynamic> json) =>
      _$HomePageModelFromJson(json);

  /// Converts HomePageModel instance to JSON
  @override
  Map<String, dynamic> toJson() => _$HomePageModelToJson(this);
}

/// Citizen Home Data
/// 
/// Contains citizen information for home page
@JsonSerializable()
class CitizenHomeData {
  /// Citizen ID (can be int or String from API)
  @JsonKey(fromJson: _idFromJson)
  final String? id;
  
  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// First name
  @JsonKey(name: 'firstName')
  final String? firstName;

  /// Middle name
  @JsonKey(name: 'middleName')
  final String? middleName;

  /// Last name
  @JsonKey(name: 'lastName')
  final String? lastName;

  /// Identity verification status (can be bool or String from API)
  @JsonKey(name: 'identityVerificationStatus')
  @IdentityVerificationStatusConverter()
  final String? identityVerificationStatus;

  CitizenHomeData({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.identityVerificationStatus,
  });

  /// Creates a CitizenHomeData instance from JSON
  factory CitizenHomeData.fromJson(Map<String, dynamic> json) =>
      _$CitizenHomeDataFromJson(json);

  /// Converts CitizenHomeData instance to JSON
  Map<String, dynamic> toJson() => _$CitizenHomeDataToJson(this);

  /// Gets full name
  String get fullName {
    final parts = [firstName, middleName, lastName].where((part) => part != null && part!.isNotEmpty).toList();
    return parts.join(' ');
  }
}

/// Service Request Model
/// 
/// Represents a service request made by the citizen
@JsonSerializable()
class ServiceRequestModel {
  /// Request ID (can be int or String from API)
  @JsonKey(fromJson: _idFromJson)
  final String? id;
  
  /// Helper to convert ID from int or String to String
  static String? _idFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Increment ID (display ID)
  @JsonKey(name: 'incrementId')
  final String? incrementId;

  /// Request status
  final String? status;

  /// Service information
  final ServiceRequestService? service;

  /// Created date
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  ServiceRequestModel({
    this.id,
    this.incrementId,
    this.status,
    this.service,
    this.createdAt,
  });

  /// Creates a ServiceRequestModel instance from JSON
  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestModelFromJson(json);

  /// Converts ServiceRequestModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceRequestModelToJson(this);
}

/// Service Request Service Model
/// 
/// Service information within a service request
@JsonSerializable()
class ServiceRequestService {
  /// Service ID (can be int or String from API)
  @JsonKey(fromJson: _serviceRequestServiceIdFromJson)
  final String? id;
  
  /// Helper to convert Service ID from int or String to String
  static String? _serviceRequestServiceIdFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Service name
  final String? name;

  ServiceRequestService({
    this.id,
    this.name,
  });

  /// Creates a ServiceRequestService instance from JSON
  factory ServiceRequestService.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestServiceFromJson(json);

  /// Converts ServiceRequestService instance to JSON
  Map<String, dynamic> toJson() => _$ServiceRequestServiceToJson(this);
}

/// Service Request List Model
/// 
/// Contains paginated list of service requests
@JsonSerializable()
class ServiceRequestListModel {
  /// List of service requests
  final List<ServiceRequestModel>? data;

  /// Pagination information
  @JsonKey(name: 'paginatorInfo')
  final PaginatorInfo? paginatorInfo;

  ServiceRequestListModel({
    this.data,
    this.paginatorInfo,
  });

  /// Creates a ServiceRequestListModel instance from JSON
  factory ServiceRequestListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestListModelFromJson(json);

  /// Converts ServiceRequestListModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceRequestListModelToJson(this);
}

/// Service Home Model
/// 
/// Represents a service on the home page (simplified)
@JsonSerializable()
class ServiceHomeModel {
  /// Service ID (can be int or String from API)
  @JsonKey(fromJson: _serviceIdFromJson)
  final String? id;
  
  /// Helper to convert Service ID from int or String to String
  static String? _serviceIdFromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is int) return json.toString();
    return json.toString();
  }

  /// Service name
  final String? name;

  /// Service base image (URL string)
  @JsonKey(name: 'baseImage')
  final String? baseImage;

  ServiceHomeModel({
    this.id,
    this.name,
    this.baseImage,
  });

  /// Creates a ServiceHomeModel instance from JSON
  factory ServiceHomeModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceHomeModelFromJson(json);

  /// Converts ServiceHomeModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceHomeModelToJson(this);

  /// Gets image URL from baseImage (baseImage is already the URL string)
  String? get imageUrl => baseImage;
}

/// Service Home List Model
/// 
/// Contains paginated list of services for home page
@JsonSerializable()
class ServiceHomeListModel {
  /// List of services
  final List<ServiceHomeModel>? data;

  /// Pagination information
  @JsonKey(name: 'paginatorInfo')
  final PaginatorInfo? paginatorInfo;

  ServiceHomeListModel({
    this.data,
    this.paginatorInfo,
  });

  /// Creates a ServiceHomeListModel instance from JSON
  factory ServiceHomeListModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceHomeListModelFromJson(json);

  /// Converts ServiceHomeListModel instance to JSON
  Map<String, dynamic> toJson() => _$ServiceHomeListModelToJson(this);
}

/// Paginator Info Model
/// 
/// Contains pagination information
@JsonSerializable()
class PaginatorInfo {
  /// Total count
  final int? total;

  /// Current page
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  /// Last page
  @JsonKey(name: 'lastPage')
  final int? lastPage;

  /// Whether there are more pages
  @JsonKey(name: 'hasMorePages')
  final bool? hasMorePages;

  PaginatorInfo({
    this.total,
    this.currentPage,
    this.lastPage,
    this.hasMorePages,
  });

  /// Creates a PaginatorInfo instance from JSON
  factory PaginatorInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginatorInfoFromJson(json);

  /// Converts PaginatorInfo instance to JSON
  Map<String, dynamic> toJson() => _$PaginatorInfoToJson(this);
}

