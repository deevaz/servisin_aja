class Vehicle {
  final String id;
  final String name;
  final String type;
  final String brand;
  final String model;
  final String plateNumber;
  final String imageAsset;

  Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.brand,
    required this.model,
    required this.plateNumber,
    required this.imageAsset,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? 'Motor',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      imageAsset: json['imageAsset'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'brand': brand,
      'model': model,
      'plateNumber': plateNumber,
      'imageAsset': imageAsset,
    };
  }
}
