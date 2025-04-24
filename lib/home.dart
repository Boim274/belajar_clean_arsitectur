import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final routes = {
      'Produk': '/produk',
      'Kategori Produk': '/kategori',
      'Jenis Produk': '/jenis',
      'Suplier': '/suplier',
      'Gudang': '/gudang',
      'Kurir': '/kurir',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu CRUD',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...routes.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () => context.go(entry.value),
                    child: Text(entry.key),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
