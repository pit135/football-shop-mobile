import 'package:flutter/material.dart';
import 'package:pf_shop/models/product_entry.dart';
import 'package:pf_shop/widgets/product_card.dart';
import 'package:pf_shop/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class MyProductListPage extends StatefulWidget {
  const MyProductListPage({super.key});

  @override
  State<MyProductListPage> createState() => _MyProductListPageState();
}

class _MyProductListPageState extends State<MyProductListPage> {
  Future<List<ProductEntry>> fetchMyProducts(CookieRequest request) async {
    // Kalau jalan di Chrome / web -> http://localhost:8000
    // Kalau jalan di Android emulator -> http://10.0.2.2:8000
    final response = await request.get('http://localhost:8000/my-products-json/');

    List<ProductEntry> myProducts = [];
    for (var d in response) {
      if (d != null) {
        myProducts.add(ProductEntry.fromJson(d));
      }
    }
    return myProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchMyProducts(request),
        builder: (context, AsyncSnapshot snapshot) {
          // Masih loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tidak ada data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Kamu belum punya produk di Football Shop.',
                style: TextStyle(fontSize: 18, color: Color(0xff59A5D8)),
                textAlign: TextAlign.center,
              ),
            );
          }

          // Ada data -> tampilkan list
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) {
              final product = snapshot.data![index];
              return ProductCard(
              product: product,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Detail produk: ${product.name}")),
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
