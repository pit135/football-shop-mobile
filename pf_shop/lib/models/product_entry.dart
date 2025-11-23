// lib/models/product_entry.dart
class ProductEntry {
  final String id;
  final String name;
  final int price;
  final int stock;
  final String brand;
  final String size;
  final String category;
  final bool isFeatured;
  final String description;
  final String thumbnail;
  final DateTime createdAt;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.brand,
    required this.size,
    required this.category,
    required this.isFeatured,
    required this.description,
    required this.thumbnail,
    required this.createdAt,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) {
    // Support dua bentuk:
    // 1) {"model": "...", "pk": "....", "fields": {...}}
    // 2) {"id": "...", "name": "...", ...} (kalau pakai JsonResponse custom)
    final fields = json['fields'] ?? json;

    return ProductEntry(
      id: (json['pk'] ?? fields['id'] ?? '').toString(),
      name: fields['name'] ?? '',
      price: fields['price'] ?? 0,
      stock: fields['stock'] ?? 0,
      brand: fields['brand'] ?? '',
      size: fields['size'] ?? '',
      category: fields['category'] ?? '',
      isFeatured: fields['is_featured'] ?? false,
      description: fields['description'] ?? '',
      thumbnail: fields['thumbnail'] ?? '',
      createdAt: DateTime.tryParse(fields['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
