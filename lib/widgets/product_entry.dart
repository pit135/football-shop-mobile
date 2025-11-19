class ProductEntry {
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final int price;
  final int stock;
  final String brand;
  final String size;
  final String category;
  final bool isFeatured;
  final DateTime createdAt;

  ProductEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.stock,
    required this.brand,
    required this.size,
    required this.category,
    required this.isFeatured,
    required this.createdAt,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'];
    return ProductEntry(
      id: json['pk'],
      name: fields['name'],
      description: fields['description'],
      thumbnail: fields['thumbnail'] ?? '',
      price: fields['price'],
      stock: fields['stock'],
      brand: fields['brand'] ?? '',
      size: fields['size'] ?? '',
      category: fields['category'] ?? '',
      isFeatured: fields['is_featured'] ?? false,
      createdAt: DateTime.parse(fields['created_at']),
    );
  }
}
