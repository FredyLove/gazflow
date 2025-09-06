import 'package:flutter/material.dart';
import 'package:gazflow/features/store_manager_dashboard/models/storage_location.dart';

class ManageLocationsScreen extends StatefulWidget {
  const ManageLocationsScreen({super.key});

  @override
  State<ManageLocationsScreen> createState() => _ManageLocationsScreenState();
}

class _ManageLocationsScreenState extends State<ManageLocationsScreen> {
  List<StorageLocation> locations = [
    StorageLocation(
      id: "LOC001",
      name: "Warehouse A - Main",
      address: "Rue de la Réunification, Yaoundé",
      capacity: 500,
      currentStock: 425,
      status: LocationStatus.active,
    ),
    StorageLocation(
      id: "LOC002",
      name: "Warehouse B - Secondary",
      address: "Quartier Mvog-Ada, Yaoundé",
      capacity: 300,
      currentStock: 50,
      status: LocationStatus.lowStock,
    ),
    StorageLocation(
      id: "LOC003",
      name: "Storage Point C",
      address: "Bastos, Yaoundé",
      capacity: 200,
      currentStock: 180,
      status: LocationStatus.active,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Manage Storage Locations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            onPressed: () => _showAddLocationDialog(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return _buildLocationCard(location, index);
        },
      ),
    );
  }

  Widget _buildLocationCard(StorageLocation location, int index) {
    final stockPercentage = (location.currentStock / location.capacity).clamp(0.0, 1.0);
    final statusColor = _getStatusColor(location.status);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location.id,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Text(
                  _getStatusText(location.status),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Address
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey[600], size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  location.address,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Stock Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Stock Level",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${location.currentStock}/${location.capacity}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: stockPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: stockPercentage > 0.2 ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  "Edit",
                  Icons.edit,
                  Colors.blue,
                  () => _showEditLocationDialog(location, index),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  "View Bottles",
                  Icons.propane_tank,
                  Colors.green,
                  () => _viewLocationBottles(location),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                  "Delete",
                  Icons.delete,
                  Colors.red,
                  () => _confirmDeleteLocation(location, index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(LocationStatus status) {
    switch (status) {
      case LocationStatus.active:
        return Colors.green;
      case LocationStatus.lowStock:
        return Colors.orange;
      case LocationStatus.inactive:
        return Colors.red;
    }
  }

  String _getStatusText(LocationStatus status) {
    switch (status) {
      case LocationStatus.active:
        return "Active";
      case LocationStatus.lowStock:
        return "Low Stock";
      case LocationStatus.inactive:
        return "Inactive";
    }
  }

  void _showAddLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => LocationDialog(
        onSave: (location) {
          setState(() {
            locations.add(location);
          });
        },
      ),
    );
  }

  void _showEditLocationDialog(StorageLocation location, int index) {
    showDialog(
      context: context,
      builder: (context) => LocationDialog(
        location: location,
        onSave: (updatedLocation) {
          setState(() {
            locations[index] = updatedLocation;
          });
        },
      ),
    );
  }

  void _confirmDeleteLocation(StorageLocation location, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Location"),
        content: Text("Are you sure you want to delete '${location.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                locations.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Location deleted successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _viewLocationBottles(StorageLocation location) {
    Navigator.pushNamed(
      context,
      '/location-bottles',
      arguments: location,
    );
  }
}

// Location Dialog for Add/Edit
class LocationDialog extends StatefulWidget {
  final StorageLocation? location;
  final Function(StorageLocation) onSave;

  const LocationDialog({
    super.key,
    this.location,
    required this.onSave,
  });

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _capacityController;
  late TextEditingController _currentStockController;
  LocationStatus _selectedStatus = LocationStatus.active;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.location?.name ?? '');
    _addressController = TextEditingController(text: widget.location?.address ?? '');
    _capacityController = TextEditingController(text: widget.location?.capacity.toString() ?? '');
    _currentStockController = TextEditingController(text: widget.location?.currentStock.toString() ?? '0');
    _selectedStatus = widget.location?.status ?? LocationStatus.active;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(widget.location == null ? "Add Location" : "Edit Location"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Location Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter location name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter address";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: "Capacity",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter capacity";
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return "Please enter valid capacity";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _currentStockController,
                decoration: const InputDecoration(
                  labelText: "Current Stock",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter current stock";
                  }
                  if (int.tryParse(value) == null || int.parse(value) < 0) {
                    return "Please enter valid stock number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<LocationStatus>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                items: LocationStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(_getStatusText(status)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _saveLocation,
          child: Text(widget.location == null ? "Add" : "Update"),
        ),
      ],
    );
  }

  String _getStatusText(LocationStatus status) {
    switch (status) {
      case LocationStatus.active:
        return "Active";
      case LocationStatus.lowStock:
        return "Low Stock";
      case LocationStatus.inactive:
        return "Inactive";
    }
  }

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      final location = StorageLocation(
        id: widget.location?.id ?? "LOC${DateTime.now().millisecondsSinceEpoch}",
        name: _nameController.text,
        address: _addressController.text,
        capacity: int.parse(_capacityController.text),
        currentStock: int.parse(_currentStockController.text),
        status: _selectedStatus,
      );

      widget.onSave(location);
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.location == null ? "Location added successfully" : "Location updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _capacityController.dispose();
    _currentStockController.dispose();
    super.dispose();
  }
}