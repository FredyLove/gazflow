import 'package:gazflow/features/driver_dashboard/models/delivery_status.dart';


class DeliveryOrder {
  final String id;
  final String customerName;
  final String address;
  final String phone;
  final String gasType;
  final DeliveryStatus status;
  final String estimatedTime;
  final String distance;

  DeliveryOrder({
    required this.id,
    required this.customerName,
    required this.address,
    required this.phone,
    required this.gasType,
    required this.status,
    required this.estimatedTime,
    required this.distance,
  });

  DeliveryOrder copyWith({
    String? id,
    String? customerName,
    String? address,
    String? phone,
    String? gasType,
    DeliveryStatus? status,
    String? estimatedTime,
    String? distance,
  }) {
    return DeliveryOrder(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      gasType: gasType ?? this.gasType,
      status: status ?? this.status,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      distance: distance ?? this.distance,
    );
  }
}