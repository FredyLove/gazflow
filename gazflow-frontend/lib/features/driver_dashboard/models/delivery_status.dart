import 'package:flutter/material.dart';


enum DeliveryStatus {
  assigned,
  pickedUp,
  inTransit,
  delivered,
}

extension DeliveryStatusExtension on DeliveryStatus {
  String get displayText {
    switch (this) {
      case DeliveryStatus.assigned:
        return "Assigned";
      case DeliveryStatus.pickedUp:
        return "Picked Up";
      case DeliveryStatus.inTransit:
        return "In Transit";
      case DeliveryStatus.delivered:
        return "Delivered";
    }
  }

  Color get color {
    switch (this) {
      case DeliveryStatus.assigned:
        return Colors.blue;
      case DeliveryStatus.pickedUp:
        return Colors.orange;
      case DeliveryStatus.inTransit:
        return Colors.purple;
      case DeliveryStatus.delivered:
        return Colors.green;
    }
  }
}