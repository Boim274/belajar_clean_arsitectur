import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/keranjang/domain/entities/keranjang.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  @override
  void initState() {
    super.initState();
    // Load keranjang when the page is opened
    context.read<KeranjangBloc>().add(KeranjangEventGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
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
      drawer: CustomDrawer(),
      body: BlocListener<KeranjangBloc, KeranjangState>(
        listener: (context, state) {
          if (state is KeranjangStateSuccess) {
            // Refresh the keranjang list after successful operation
            context.read<KeranjangBloc>().add(KeranjangEventGetAll());
          }

          if (state is KeranjangStateError) {
            // Show error message
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<KeranjangBloc, KeranjangState>(
          builder: (context, state) {
            if (state is KeranjangStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is KeranjangStateLoadedAll) {
              final keranjangs = state.keranjangs;
              if (keranjangs.isEmpty) {
                return const Center(
                  child: Text('Keranjang kosong',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                );
              }

              return ListView.builder(
                itemCount: keranjangs.length,
                itemBuilder: (context, index) {
                  var keranjang = keranjangs[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          '${index + 1}', // index mulai dari 0, jadi tambahkan +1
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        keranjang.namaProduk,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp: ${keranjang.harga}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4), // Jarak kecil antar teks
                          Text(
                            'Qty: ${keranjang.quantity}', // Menampilkan quantity
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Show confirmation dialog before deleting
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Konfirmasi'),
                              content: const Text(
                                  'Yakin ingin menghapus produk ini?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Tidak'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Perform delete operation
                                    context.read<KeranjangBloc>().add(
                                        KeranjangEventDelete(id: keranjang.id));
                                    // Close the dialog after delete operation
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ya'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
