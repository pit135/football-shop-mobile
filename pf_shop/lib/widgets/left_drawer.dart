import 'package:flutter/material.dart';
import 'package:pf_shop/screens/menu.dart';
import 'package:pf_shop/screens/product_form.dart';
import 'package:pf_shop/screens/product_list_page.dart';
import 'package:pf_shop/screens/my_product_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade700,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Football Shop',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Semua perlengkapan sepak bola\nada di sini!',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Halaman Utama
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),

          // Tambah Produk
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Tambah Produk'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductFormPage()),
              );
            },
          ),

          // Semua produk
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('All Products'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductListPage()),
              );
            },
          ),

          // Produk milikku
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('My Products'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyProductListPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
