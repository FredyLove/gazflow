enum BottleSize { small6kg, medium12kg, large25kg }
enum BottleStatus { available, reserved, delivered, maintenance }

class GasBottle {
  final String id;
  final String locationId;
  final BottleSize size;
  final BottleStatus status;
  final double price;
  final DateTime? lastInspection;
  final DateTime? expiryDate;
  final String? batchNumber;
  final int quantity;

  GasBottle({
    required this.id,
    required this.locationId,
    required this.size,
    required this.status,
    required this.price,
    required this.quantity,
    this.lastInspection,
    this.expiryDate,
    this.batchNumber,
  });

  GasBottle copyWith({
    String? id,
    String? locationId,
    BottleSize? size,
    BottleStatus? status,
    double? price,
    int? quantity,
    DateTime? lastInspection,
    DateTime? expiryDate,
    String? batchNumber,
  }) {
    return GasBottle(
      id: id ?? this.id,
      locationId: locationId ?? this.locationId,
      size: size ?? this.size,
      status: status ?? this.status,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      lastInspection: lastInspection ?? this.lastInspection,
      expiryDate: expiryDate ?? this.expiryDate,
      batchNumber: batchNumber ?? this.batchNumber,
    );
  }

  String get sizeText {
    switch (size) {
      case BottleSize.small6kg:
        return "6kg";
      case BottleSize.medium12kg:
        return "12.5kg";
      case BottleSize.large25kg:
        return "25kg";
    }
  }

  String get statusText {
    switch (status) {
      case BottleStatus.available:
        return "Available";
      case BottleStatus.reserved:
        return "Reserved";
      case BottleStatus.delivered:
        return "Delivered";
      case BottleStatus.maintenance:
        return "Maintenance";
    }
  }

  bool get needsInspection {
    if (lastInspection == null) return true;
    return DateTime.now().difference(lastInspection!).inDays > 365;
  }

  bool get isExpired {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'locationId': locationId,
      'size': size.toString(),
      'status': status.toString(),
      'price': price,
      'quantity': quantity,
      'lastInspection': lastInspection?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'batchNumber': batchNumber,
    };
  }

  factory GasBottle.fromJson(Map<String, dynamic> json) {
    return GasBottle(
      id: json['id'],
      locationId: json['locationId'],
      size: BottleSize.values.firstWhere(
        (e) => e.toString() == json['size'],
        orElse: () => BottleSize.medium12kg,
      ),
      status: BottleStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => BottleStatus.available,
      ),
      price: json['price']?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      lastInspection: json['lastInspection'] != null
          ? DateTime.parse(json['lastInspection'])
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      batchNumber: json['batchNumber'],
    );
  }
}