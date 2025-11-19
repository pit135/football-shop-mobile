import 'package:flutter/material.dart';
import 'package:pf_shop/models/product_entry.dart';
import 'package:pf_shop/screens/product_detail.dart';
import 'package:pf_shop/widgets/product_card.dart';
import 'package:pf_shop/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

// Chrome/web
const String baseUrl = 'http://localhost:8000';
// Emulator Android: const String baseUrl = 'http://10.0.2.2:8000';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request.get('$baseUrl/show-json/');

    List<ProductEntry> listProducts = [];
    for (var d in response) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada produk di Football Shop.',
                style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
              ),
            );
          }

          final products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,        // 3 kolom
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.70,  
            ),
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
