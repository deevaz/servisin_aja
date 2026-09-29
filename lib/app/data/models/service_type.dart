class ServiceType {
  final String id;
  final String name;
  final String description;
  final int basePrice;
  final int estimatedMinutes;
  final String icon;

  ServiceType({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.estimatedMinutes,
    required this.icon,
  });

  factory ServiceType.fromJson(Map<String, dynamic> json) {
    return ServiceType(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      basePrice: json['basePrice'] ?? 0,
      estimatedMinutes: json['estimatedMinutes'] ?? 0,
      icon: json['icon'] ?? 'build',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'basePrice': basePrice,
      'estimatedMinutes': estimatedMinutes,
      'icon': icon,
    };
  }
}
