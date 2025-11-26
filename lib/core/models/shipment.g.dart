// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shipment _$ShipmentFromJson(Map<String, dynamic> json) => Shipment(
      id: json['id'] as String?,
      consigneeNumber: json['consigneeNumber'] as String,
      service: $enumDecode(_$ServiceTypeEnumMap, json['service']),
      status: $enumDecode(_$ShipmentStatusEnumMap, json['status']),
      companyName: json['companyName'] as String,
      shipperName: json['shipperName'] as String,
      shipperPhone: json['shipperPhone'] as String,
      shipperAddress: json['shipperAddress'] as String,
      shipperCountry: json['shipperCountry'] as String,
      shipperCity: json['shipperCity'] as String,
      shipperPostal: json['shipperPostal'] as String,
      consigneeCompanyName: json['consigneeCompanyName'] as String,
      receiverName: json['receiverName'] as String,
      receiverEmail: json['receiverEmail'] as String,
      receiverPhone: json['receiverPhone'] as String,
      receiverAddress: json['receiverAddress'] as String,
      receiverCountry: json['receiverCountry'] as String,
      receiverCity: json['receiverCity'] as String,
      receiverZip: json['receiverZip'] as String,
      accountNo: json['accountNo'] as String,
      shipmentType: $enumDecode(_$ShipmentTypeEnumMap, json['shipmentType']),
      pieces: (json['pieces'] as num).toInt(),
      description: json['description'] as String,
      fragile: json['fragile'] as bool? ?? false,
      currency: $enumDecode(_$CurrencyTypeEnumMap, json['currency']),
      shipperReference: json['shipperReference'] as String?,
      comments: json['comments'] as String?,
      totalVolumetricWeight:
          (json['totalVolumetricWeight'] as num?)?.toDouble(),
      dimensions: json['dimensions'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      invoiceType:
          $enumDecodeNullable(_$InvoiceTypeEnumMap, json['invoiceType']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ShipmentToJson(Shipment instance) => <String, dynamic>{
      'id': instance.id,
      'consigneeNumber': instance.consigneeNumber,
      'service': _$ServiceTypeEnumMap[instance.service]!,
      'status': _$ShipmentStatusEnumMap[instance.status]!,
      'companyName': instance.companyName,
      'shipperName': instance.shipperName,
      'shipperPhone': instance.shipperPhone,
      'shipperAddress': instance.shipperAddress,
      'shipperCountry': instance.shipperCountry,
      'shipperCity': instance.shipperCity,
      'shipperPostal': instance.shipperPostal,
      'consigneeCompanyName': instance.consigneeCompanyName,
      'receiverName': instance.receiverName,
      'receiverEmail': instance.receiverEmail,
      'receiverPhone': instance.receiverPhone,
      'receiverAddress': instance.receiverAddress,
      'receiverCountry': instance.receiverCountry,
      'receiverCity': instance.receiverCity,
      'receiverZip': instance.receiverZip,
      'accountNo': instance.accountNo,
      'shipmentType': _$ShipmentTypeEnumMap[instance.shipmentType]!,
      'pieces': instance.pieces,
      'description': instance.description,
      'fragile': instance.fragile,
      'currency': _$CurrencyTypeEnumMap[instance.currency]!,
      'shipperReference': instance.shipperReference,
      'comments': instance.comments,
      'totalVolumetricWeight': instance.totalVolumetricWeight,
      'dimensions': instance.dimensions,
      'weight': instance.weight,
      'invoiceType': _$InvoiceTypeEnumMap[instance.invoiceType],
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.express: 'express',
  ServiceType.standard: 'standard',
  ServiceType.economy: 'economy',
  ServiceType.overnight: 'overnight',
  ServiceType.international: 'international',
};

const _$ShipmentStatusEnumMap = {
  ShipmentStatus.pending: 'pending',
  ShipmentStatus.inTransit: 'inTransit',
  ShipmentStatus.delivered: 'delivered',
  ShipmentStatus.cancelled: 'cancelled',
  ShipmentStatus.returned: 'returned',
  ShipmentStatus.onHold: 'onHold',
};

const _$ShipmentTypeEnumMap = {
  ShipmentType.docs: 'docs',
  ShipmentType.nonDocsFlyer: 'nonDocsFlyer',
  ShipmentType.nonDocsBox: 'nonDocsBox',
};

const _$CurrencyTypeEnumMap = {
  CurrencyType.usd: 'usd',
  CurrencyType.eur: 'eur',
  CurrencyType.gbp: 'gbp',
  CurrencyType.aed: 'aed',
  CurrencyType.pkr: 'pkr',
};

const _$InvoiceTypeEnumMap = {
  InvoiceType.commercial: 'commercial',
  InvoiceType.gift: 'gift',
  InvoiceType.performance: 'performance',
  InvoiceType.sample: 'sample',
};
