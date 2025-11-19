import 'package:flutter/material.dart';
import 'package:pf_shop/widgets/left_drawer.dart';
// Impor halaman-halaman yang dituju
import 'package:pf_shop/screens/product_list_page.dart'; 
import 'package:pf_shop/screens/my_product_list.dart'; 
import 'package:pf_shop/screens/product_form.dart'; 

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'Football Shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const LeftDrawer(),
      body: Container(
        color: Colors.green.shade50,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PF Shop',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Everything you want in football is right here',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // INFO CARD: Nama, NPM, Kelas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoCard('Nama', 'Petrus Wermasaubun'),
                  _infoCard('NPM', '2406344542'),
                  _infoCard('Kelas', 'B'),
                ],
              ),

              const SizedBox(height: 30),

              // menu buttons (3 kotak warna)
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _menuBox(
                    context,
                    color: Colors.blue,
                    icon: Icons.list_alt,
                    text: 'All Products',
                    onTap: () {
                      // Navigasi Langsung ke ProductListPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductListPage(),
                        ),
                      );
                    },
                  ),
                  _menuBox(
                    context,
                    color: Colors.green,
                    icon: Icons.shopping_bag_outlined,
                    text: 'My Products',
                    onTap: () {
                      // Navigasi Langsung ke MyProductListPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyProductListPage(),
                        ),
                      );
                    },
                  ),
                  _menuBox(
                    context,
                    color: Colors.red,
                    icon: Icons.add_circle_outline,
                    text: 'Create Product',
                    onTap: () {
                      // Navigasi Langsung ke ProductFormPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductFormPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // kartu kecil (Nama, NPM, Kelas)
  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(value),
          ],
        ),
      ),
    );
  }

  // kotak menu besar (All Products, My Products, Create Product)
  Widget _menuBox(BuildContext context,
      {required Color color,
      required IconData icon,
      required String text,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}