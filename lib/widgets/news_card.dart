import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String category;
  final String thumbnailUrl;
  final bool isFeatured;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.thumbnailUrl,
    required this.isFeatured,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: thumbnailUrl.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(thumbnailUrl),
              )
            : const CircleAvatar(
                child: Icon(Icons.sports_soccer),
              ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Kategori: $category\n'
          '${isFeatured ? "Produk Unggulan" : "Produk biasa"}',
        ),
        trailing: Text(
          'Rp $price',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
