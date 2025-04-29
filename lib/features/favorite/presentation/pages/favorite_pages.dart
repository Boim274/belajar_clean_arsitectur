import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePages extends StatelessWidget {
   FavoritePages({super.key});

  // Pakai myinjection, BUKAN Hive.box langsung
  final Box user = myinjection<Box>();

  // Fungsi untuk menghapus produk dari koleksi favorite user
  Future<void> removeFavorite(String favoriteId) async {
    try {
      final uid = user.get('uid');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorite')
          .doc(favoriteId)
          .delete();
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = user.get('uid');

    final favoriteCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite');

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites available.'));
          }

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

              final produkList = produkSnapshot.data ?? [];
              return ListView.builder(
                itemCount: produkList.length,
                itemBuilder: (context, index) {
                  final produk = produkList[index];
                  final favoriteId = favoriteDocs[index].id;

                  if (produk.isEmpty) return Container(); // skip produk kosong

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
                          removeFavorite(favoriteId);
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
