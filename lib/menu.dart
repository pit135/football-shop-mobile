import 'package:flutter/material.dart';

// model untuk tombol home
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String snackbarMessage;

  ItemHomepage(
    this.name,
    this.icon, {
    required this.color,
    required this.snackbarMessage,
  });
}

// card indentitas
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// widget tombol
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // warna
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // snackbar
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(item.snackbarMessage),
              ),
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  size: 32.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// main page
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // identitas
  final String nama = "Petrus Wermasaubun";
  final String npm = "2406344542";
  final String kelas = "B";

  // 3 tombol
  final List<ItemHomepage> items = [
    ItemHomepage(
      "All Products",
      Icons.list_alt,
      color: Colors.blue, // biru
      snackbarMessage: "Kamu telah menekan tombol All Products",
    ),
    ItemHomepage(
      "My Products",
      Icons.shopping_bag,
      color: Colors.green, // hijau
      snackbarMessage: "Kamu telah menekan tombol My Products",
    ),
    ItemHomepage(
      "Create Product",
      Icons.add_circle_outline,
      color: Colors.red, // merah
      snackbarMessage: "Kamu telah menekan tombol Create Product",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f4f6),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          'Football Shop',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: const Border(
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "PF Shop",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Everything you want in football is right here",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(title: "Nama", content: nama),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InfoCard(title: "NPM", content: npm),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InfoCard(title: "Kelas", content: kelas),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // grid 3 tombol
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((item) => ItemCard(item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
