class Workshop {
  final String id;
  final String name;
  final String address;
  final double distanceKm;
  final double rating;
  final int reviewCount;
  final String imageAsset;
  final String openHours;

  Workshop({
    required this.id,
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.rating,
    required this.reviewCount,
    required this.imageAsset,
    required this.openHours,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      imageAsset: json['imageAsset'] ?? '',
      openHours: json['openHours'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'distanceKm': distanceKm,
      'rating': rating,
      'reviewCount': reviewCount,
      'imageAsset': imageAsset,
      'openHours': openHours,
    };
  }
}
