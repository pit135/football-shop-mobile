// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:pf_shop/models/product_entry.dart';

// GUNAKAN INI UNTUK CHROME / WEB
const String baseUrl = 'http://localhost:8000';
// Kalau pakai Android emulator ganti jadi:
// const String baseUrl = 'http://10.0.2.2:8000';

class ProductCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: const Color(0xFFF7FFF7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======= HEADER (CATEGORY CHIP + FEATURED BADGE) =======
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _formatCategory(product.category),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Featured badge
                  if (product.isFeatured)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE08A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.star,
                            size: 18,
                            color: Color(0xFFF5A623),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Featured',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7B4D00),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // ======= THUMBNAIL BESAR =======
            AspectRatio(
              aspectRatio: 16 / 9,
              child: product.thumbnail.isNotEmpty
                  ? Image.network(
                      '$baseUrl/proxy-image/?url=${Uri.encodeComponent(product.thumbnail)}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
            ),

            // ======= BODY =======
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tanggal dibuat (kalau ada)
                  if (product.createdAt != null)
                    Text(
                      _formatDate(product.createdAt!),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  if (product.createdAt != null) const SizedBox(height: 8),

                  // Nama produk
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Deskripsi singkat
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Harga
                  Text(
                    'Rp ${product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Brand
                  Text(
                    product.brand,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ======= FOOTER: TOMBOL DETAIL =======
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Detail',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategory(String category) {
    switch (category.toLowerCase()) {
      case 'jersey':
        return 'Jersey';
      case 'shoes':
        return 'Shoes';
      case 'ball':
        return 'Ball';
      case 'accessory':
        return 'Accessory';
      default:
        return category;
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
