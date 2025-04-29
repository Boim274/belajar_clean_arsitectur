import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:belajar_clean_arsitectur/features/favorite/data/models/favorite_model.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/data/models/keranjang_model.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProdukCardPages extends StatelessWidget {
  ProdukCardPages({super.key});

  // Pakai myinjection supaya tidak error Hive
  final Box user = myinjection<Box>();

  @override
  Widget build(BuildContext context) {
    final productsCollection = FirebaseFirestore.instance.collection('produks');
    final favoriteDataSource = FavoriteRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Card'),
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          final products = snapshot.data!.docs
              .map((doc) => ProdukModel.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final produk = products[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(produk.namaProduk),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Harga: ${produk.harga}'),
                      Text('Deskripsi: ${produk.deskripsi}'),
                      Text('Kategori: ${produk.kategoriId}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('favorites')
                            .where('produkId', isEqualTo: produk.id)
                            .limit(1)
                            .get(),
                        builder: (context, favoriteSnapshot) {
                          if (favoriteSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Icon(Icons.favorite_border);
                          }
                          if (favoriteSnapshot.hasError) {
                            return const Icon(Icons.favorite_border);
                          }

                          bool isFavorite = favoriteSnapshot.hasData &&
                              favoriteSnapshot.data!.docs.isNotEmpty;

                          return IconButton(
                            icon: Icon(isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () async {
                              final favoriteItem = FavoriteModel(
                                id: produk.id,
                                produkId: produk.id,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                isNew: true,
                              );

                              try {
                                await favoriteDataSource.addFavorite(
                                    favorite: favoriteItem);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '${produk.namaProduk} ditambahkan ke favorit')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Gagal menambahkan ke favorit')),
                                );
                              }
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {
                          // Mengirim event untuk menambahkan produk ke keranjang
                          context.read<KeranjangBloc>().add(
                                KeranjangEventAdd(
                                  keranjangModel: KeranjangModel(
                                    id: UniqueKey()
                                        .toString(), // atau ID yang sesuai dari database
                                    produkId: produk.id,
                                    namaProduk: produk.namaProduk,
                                    harga: produk.harga,
                                    quantity:
                                        1, // Jumlah produk yang ditambahkan ke keranjang
                                  ),
                                ),
                              );

                          // Menampilkan SnackBar setelah produk berhasil ditambahkan ke keranjang
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    '${produk.namaProduk} berhasil ditambahkan ke keranjang')),
                          );
                        },
                      ),
                    ],
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
