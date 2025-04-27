import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProdukCardPages extends StatelessWidget {
  const ProdukCardPages({super.key});

  // Fungsi untuk menambahkan atau menghapus produk dari koleksi favorite
  Future<void> toggleFavorite(ProdukModel produk, BuildContext context) async {
    final favoriteCollection =
        FirebaseFirestore.instance.collection('favorites');
    final existingFavorite = await favoriteCollection
        .where('produkId', isEqualTo: produk.id)
        .limit(1)
        .get();

    if (existingFavorite.docs.isEmpty) {
      // Jika produk belum ada di koleksi favorite, tambahkan
      await favoriteCollection.add({
        'produkId': produk.id,
        'namaProduk': produk.namaProduk,
        'harga': produk.harga,
        'deskripsi': produk.deskripsi,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // Memberikan feedback ke pengguna bahwa produk ditambahkan ke favorit
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${produk.namaProduk} ditambahkan ke favorit!'),
      ));
    } else {
      // Jika produk sudah ada, hapus dari koleksi favorite
      await favoriteCollection.doc(existingFavorite.docs.first.id).delete();
      // Memberikan feedback ke pengguna bahwa produk dihapus dari favorit
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${produk.namaProduk} dihapus dari favorit!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Firestore collection reference
    final productsCollection = FirebaseFirestore.instance.collection('produks');

    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Card'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: productsCollection.snapshots(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Handle empty state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products available.'));
          }

          // Map Firestore documents to ProdukModel
          final products = snapshot.data!.docs
              .map((doc) => ProdukModel.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final produk = products[index];

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(produk.namaProduk),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Harga: ${produk.harga}'),
                      Text('Deskripsi: ${produk.deskripsi}'),
                      Text('Kategori: ${produk.kategoriId}'),
                    ],
                  ),
                  trailing: FutureBuilder(
                    // Periksa apakah produk sudah ada di favorit
                    future: FirebaseFirestore.instance
                        .collection('favorites')
                        .where('produkId', isEqualTo: produk.id)
                        .limit(1)
                        .get(),
                    builder: (context, favoriteSnapshot) {
                      if (favoriteSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Icon(Icons.favorite_border); // Loading state
                      }

                      if (favoriteSnapshot.hasError) {
                        return Icon(Icons.favorite_border); // Error state
                      }

                      bool isFavorite = favoriteSnapshot.hasData &&
                          favoriteSnapshot.data!.docs.isNotEmpty;

                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          toggleFavorite(produk,
                              context); // Memanggil fungsi toggleFavorite
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
