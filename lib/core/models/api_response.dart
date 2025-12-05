import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> data;
  final PaginationMeta pagination;

  PaginatedResponse({
    required this.data,
    required this.pagination,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}

@JsonSerializable()
class PaginationMeta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  PaginationMeta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}

@JsonSerializable()
class LoginResponse {
  final String token;
  final Map<String, dynamic> user;

  LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class StatusHistoryItem {
  final String id;
  final String shipmentId;
  final String status;
  final String? location;
  final String? notes;
  final String? createdBy;
  final String? createdByName;
  final DateTime createdAt;

  StatusHistoryItem({
    required this.id,
    required this.shipmentId,
    required this.status,
    this.location,
    this.notes,
    this.createdBy,
    this.createdByName,
    required this.createdAt,
  });

  factory StatusHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$StatusHistoryItemFromJson(json);
  Map<String, dynamic> toJson() => _$StatusHistoryItemToJson(this);
}

@JsonSerializable()
class TrackingResponse {
  final Map<String, dynamic> shipment;
  final List<StatusHistoryItem> statusHistory;

  TrackingResponse({
    required this.shipment,
    required this.statusHistory,
  });

  factory TrackingResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TrackingResponseToJson(this);
}
