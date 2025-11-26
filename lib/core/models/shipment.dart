import 'package:json_annotation/json_annotation.dart';
import 'enums.dart';

part 'shipment.g.dart';

@JsonSerializable()
class Shipment {
  final String? id;
  final String consigneeNumber;
  final ServiceType service;
  final ShipmentStatus status;

  // Company Info
  final String companyName;

  // Shipper Info
  final String shipperName;
  final String shipperPhone;
  final String shipperAddress;
  final String shipperCountry;
  final String shipperCity;
  final String shipperPostal;

  // Consignee Info
  final String consigneeCompanyName;
  final String receiverName;
  final String receiverEmail;
  final String receiverPhone;
  final String receiverAddress;
  final String receiverCountry;
  final String receiverCity;
  final String receiverZip;

  // Shipment Details
  final String accountNo;
  final ShipmentType shipmentType;
  final int pieces;
  final String description;
  final bool fragile;
  final CurrencyType currency;
  final String? shipperReference;
  final String? comments;

  // Box Dimensions (only for nonDocsBox)
  final double? totalVolumetricWeight;
  final String? dimensions; // LxWxH format
  final double? weight;

  // Invoice (for duplicated shipments)
  final InvoiceType? invoiceType;

  final DateTime createdAt;
  final DateTime? updatedAt;

  Shipment({
    this.id,
    required this.consigneeNumber,
    required this.service,
    required this.status,
    required this.companyName,
    required this.shipperName,
    required this.shipperPhone,
    required this.shipperAddress,
    required this.shipperCountry,
    required this.shipperCity,
    required this.shipperPostal,
    required this.consigneeCompanyName,
    required this.receiverName,
    required this.receiverEmail,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.receiverCountry,
    required this.receiverCity,
    required this.receiverZip,
    required this.accountNo,
    required this.shipmentType,
    required this.pieces,
    required this.description,
    this.fragile = false,
    required this.currency,
    this.shipperReference,
    this.comments,
    this.totalVolumetricWeight,
    this.dimensions,
    this.weight,
    this.invoiceType,
    required this.createdAt,
    this.updatedAt,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => _$ShipmentFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentToJson(this);

  Shipment copyWith({
    String? id,
    String? consigneeNumber,
    ServiceType? service,
    ShipmentStatus? status,
    String? companyName,
    String? shipperName,
    String? shipperPhone,
    String? shipperAddress,
    String? shipperCountry,
    String? shipperCity,
    String? shipperPostal,
    String? consigneeCompanyName,
    String? receiverName,
    String? receiverEmail,
    String? receiverPhone,
    String? receiverAddress,
    String? receiverCountry,
    String? receiverCity,
    String? receiverZip,
    String? accountNo,
    ShipmentType? shipmentType,
    int? pieces,
    String? description,
    bool? fragile,
    CurrencyType? currency,
    String? shipperReference,
    String? comments,
    double? totalVolumetricWeight,
    String? dimensions,
    double? weight,
    InvoiceType? invoiceType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Shipment(
      id: id ?? this.id,
      consigneeNumber: consigneeNumber ?? this.consigneeNumber,
      service: service ?? this.service,
      status: status ?? this.status,
      companyName: companyName ?? this.companyName,
      shipperName: shipperName ?? this.shipperName,
      shipperPhone: shipperPhone ?? this.shipperPhone,
      shipperAddress: shipperAddress ?? this.shipperAddress,
      shipperCountry: shipperCountry ?? this.shipperCountry,
      shipperCity: shipperCity ?? this.shipperCity,
      shipperPostal: shipperPostal ?? this.shipperPostal,
      consigneeCompanyName: consigneeCompanyName ?? this.consigneeCompanyName,
      receiverName: receiverName ?? this.receiverName,
      receiverEmail: receiverEmail ?? this.receiverEmail,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiverCountry: receiverCountry ?? this.receiverCountry,
      receiverCity: receiverCity ?? this.receiverCity,
      receiverZip: receiverZip ?? this.receiverZip,
      accountNo: accountNo ?? this.accountNo,
      shipmentType: shipmentType ?? this.shipmentType,
      pieces: pieces ?? this.pieces,
      description: description ?? this.description,
      fragile: fragile ?? this.fragile,
      currency: currency ?? this.currency,
      shipperReference: shipperReference ?? this.shipperReference,
      comments: comments ?? this.comments,
      totalVolumetricWeight: totalVolumetricWeight ?? this.totalVolumetricWeight,
      dimensions: dimensions ?? this.dimensions,
      weight: weight ?? this.weight,
      invoiceType: invoiceType ?? this.invoiceType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
