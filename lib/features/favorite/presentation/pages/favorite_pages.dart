import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritePages extends StatelessWidget {
  const FavoritePages({super.key});

  // Fungsi untuk menghapus produk dari koleksi favorite
  Future<void> removeFavorite(String favoriteId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(favoriteId)
          .delete();
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Firestore collection reference
    final favoriteCollection =
        FirebaseFirestore.instance.collection('favorites');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
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
        stream: favoriteCollection.snapshots(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Handle empty state
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites available.'));
          }

          // Ambil data produk berdasarkan produkId di koleksi favorites
          final favoriteDocs = snapshot.data!.docs;
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: Future.wait(
              favoriteDocs.map<Future<Map<String, dynamic>>>((favorite) async {
                final produkId = favorite['produkId'];
                final produkDoc = await FirebaseFirestore.instance
                    .collection('produks')
                    .doc(produkId)
                    .get();
                return produkDoc.exists
                    ? produkDoc.data() as Map<String, dynamic>
                    : {};
              }).toList(),
            ),
            builder: (context, produkSnapshot) {
              if (produkSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (produkSnapshot.hasError) {
                return Center(child: Text('Error: ${produkSnapshot.error}'));
              }

              // Menampilkan produk favorit
              final produkList = produkSnapshot.data ?? [];
              return ListView.builder(
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  final favoriteId = favoriteDocs[index].id;
                  if (produk.isEmpty)
                    return Container(); // Menghindari produk kosong
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(produk['namaProduk'] ?? 'Unknown'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Harga: ${produk['harga'] ?? 'Unknown'}'),
                          Text(
                              'Deskripsi: ${produk['deskripsi'] ?? 'No description available.'}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          removeFavorite(
                              favoriteId); // Menghapus produk dari favorit
                        },
                      ),
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
