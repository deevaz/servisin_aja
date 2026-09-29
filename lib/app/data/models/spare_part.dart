class SparePart {
  final String id;
  final String name;
  final String category;
  final int price;
  final bool optional;

  SparePart({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.optional = true,
  });

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'Sparepart',
      price: json['price'] ?? 0,
      optional: json['optional'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'optional': optional,
    };
  }
}
