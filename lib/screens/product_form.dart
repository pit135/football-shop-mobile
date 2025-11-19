import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pf_shop/widgets/left_drawer.dart';
import 'package:pf_shop/screens/menu.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

// EMULATOR ANDROID:
// const String baseUrl = 'http://10.0.2.2:8000';
// CHROME / WEB:
const String baseUrl = 'http://localhost:8000';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _description = "";
  String _thumbnail = "";
  int _price = 0;
  int _stock = 0;
  String _brand = "";
  String _size = "";
  String _category = "jersey";
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Nama Produk"),
              onChanged: (value) => _name = value,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Tidak boleh kosong" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Deskripsi"),
              onChanged: (value) => _description = value,
              maxLines: 3,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Tidak boleh kosong" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "URL Gambar"),
              onChanged: (value) => _thumbnail = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
              onChanged: (value) => _price = int.tryParse(value) ?? 0,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Tidak boleh kosong" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Stok"),
              keyboardType: TextInputType.number,
              onChanged: (value) => _stock = int.tryParse(value) ?? 0,
              validator: (value) =>
                  (value == null || value.isEmpty) ? "Tidak boleh kosong" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Brand"),
              onChanged: (value) => _brand = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Ukuran"),
              onChanged: (value) => _size = value,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: "Kategori"),
              items: const [
                DropdownMenuItem(value: 'jersey', child: Text('Jersey')),
                DropdownMenuItem(value: 'shoes', child: Text('Shoes')),
                DropdownMenuItem(value: 'ball', child: Text('Ball')),
                DropdownMenuItem(value: 'accessory', child: Text('Accessory')),
              ],
              onChanged: (value) => setState(() {
                _category = value ?? 'jersey';
              }),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text("Produk Unggulan"),
              value: _isFeatured,
              onChanged: (value) {
                setState(() {
                  _isFeatured = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Tambah Produk"),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  try {
                    final response = await request.postJson(
                      "$baseUrl/create-flutter/",
                      jsonEncode({
                        "name": _name,
                        "description": _description,
                        "thumbnail": _thumbnail,
                        "price": _price,
                        "stock": _stock,
                        "brand": _brand,
                        "size": _size,
                        "category": _category,
                        "is_featured": _isFeatured,
                      }),
                    );

                    if (!mounted) return;

                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Produk berhasil disimpan!"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Gagal menyimpan produk: ${response['message'] ?? 'Terjadi kesalahan'}",
                          ),
                        ),
                      );
                    }
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Terjadi error: $e"),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
