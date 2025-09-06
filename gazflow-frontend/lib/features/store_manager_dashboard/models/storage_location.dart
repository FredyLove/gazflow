enum LocationStatus { active, lowStock, inactive }

class StorageLocation {
  final String id;
  final String name;
  final String address;
  final int capacity;
  final int currentStock;
  final LocationStatus status;
  final DateTime? lastUpdated;
  final String? managerName;

  StorageLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.currentStock,
    required this.status,
    this.lastUpdated,
    this.managerName,
  });

  StorageLocation copyWith({
    String? id,
    String? name,
    String? address,
    int? capacity,
    int? currentStock,
    LocationStatus? status,
    DateTime? lastUpdated,
    String? managerName,
  }) {
    return StorageLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      capacity: capacity ?? this.capacity,
      currentStock: currentStock ?? this.currentStock,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      managerName: managerName ?? this.managerName,
    );
  }

  double get stockPercentage => (currentStock / capacity).clamp(0.0, 1.0);
  
  bool get isLowStock => stockPercentage < 0.2;
  
  bool get isFull => currentStock >= capacity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'currentStock': currentStock,
      'status': status.toString(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'managerName': managerName,
    };
  }

  factory StorageLocation.fromJson(Map<String, dynamic> json) {
    return StorageLocation(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      capacity: json['capacity'],
      currentStock: json['currentStock'],
      status: LocationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => LocationStatus.active,
      ),
      lastUpdated: json['lastUpdated'] != null 
          ? DateTime.parse(json['lastUpdated'])
          : null,
      managerName: json['managerName'],
    );
  }
}