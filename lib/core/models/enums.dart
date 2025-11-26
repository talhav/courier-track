enum ShipmentStatus {
  pending,
  inTransit,
  delivered,
  cancelled,
  returned,
  onHold;

  String get displayName {
    switch (this) {
      case ShipmentStatus.pending:
        return 'Pending';
      case ShipmentStatus.inTransit:
        return 'In Transit';
      case ShipmentStatus.delivered:
        return 'Delivered';
      case ShipmentStatus.cancelled:
        return 'Cancelled';
      case ShipmentStatus.returned:
        return 'Returned';
      case ShipmentStatus.onHold:
        return 'On Hold';
    }
  }
}

enum ServiceType {
  express,
  standard,
  economy,
  overnight,
  international;

  String get displayName {
    switch (this) {
      case ServiceType.express:
        return 'Express';
      case ServiceType.standard:
        return 'Standard';
      case ServiceType.economy:
        return 'Economy';
      case ServiceType.overnight:
        return 'Overnight';
      case ServiceType.international:
        return 'International';
    }
  }
}

enum ShipmentType {
  docs,
  nonDocsFlyer,
  nonDocsBox;

  String get displayName {
    switch (this) {
      case ShipmentType.docs:
        return 'Documents';
      case ShipmentType.nonDocsFlyer:
        return 'Non-Docs (Flyer)';
      case ShipmentType.nonDocsBox:
        return 'Non-Docs (Box)';
    }
  }
}

enum InvoiceType {
  commercial,
  gift,
  performance,
  sample;

  String get displayName {
    switch (this) {
      case InvoiceType.commercial:
        return 'Commercial Invoice';
      case InvoiceType.gift:
        return 'Gift Invoice';
      case InvoiceType.performance:
        return 'Performance Invoice';
      case InvoiceType.sample:
        return 'Sample Invoice';
    }
  }
}

enum CurrencyType {
  usd,
  eur,
  gbp,
  aed,
  pkr;

  String get displayName {
    switch (this) {
      case CurrencyType.usd:
        return 'USD';
      case CurrencyType.eur:
        return 'EUR';
      case CurrencyType.gbp:
        return 'GBP';
      case CurrencyType.aed:
        return 'AED';
      case CurrencyType.pkr:
        return 'PKR';
    }
  }
}
