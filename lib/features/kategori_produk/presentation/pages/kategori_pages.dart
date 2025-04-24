import 'package:belajar_clean_arsitectur/features/kategori_produk/data/models/kategori_produk_model.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KategoriPages extends StatelessWidget {
  const KategoriPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Pages'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  TextEditingController namaKategoriController =
                      TextEditingController();
                  TextEditingController deskripsiKategoriController =
                      TextEditingController();

                  // Form Key untuk validasi
                  final formKey = GlobalKey<FormState>();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input Nama Kategori
                          TextFormField(
                            controller: namaKategoriController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Kategori',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Kategori tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input Deskripsi Kategori
                          TextFormField(
                            controller: deskripsiKategoriController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi Kategori',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Deskripsi Kategori tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Tombol Simpan dengan validasi
                          BlocConsumer<KategoriProdukBloc, KategoriProdukState>(
                            listener: (context, state) {
                              if (state is KategoriProdukStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is KategoriProdukStateSuccess) {
                                context.pop();
                                context
                                    .read<KategoriProdukBloc>()
                                    .add(KategoriProdukEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<KategoriProdukBloc>().add(
                                          KategoriProdukEventAdd(
                                            kategoriProdukModel:
                                                KategoriProdukModel(
                                              id: '',
                                              namaKategori:
                                                  namaKategoriController.text,
                                              deskripsi:
                                                  deskripsiKategoriController
                                                      .text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is KategoriProdukStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Kategori'),
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
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<KategoriProdukBloc, KategoriProdukState>(
        bloc: context.read<KategoriProdukBloc>()
          ..add(KategoriProdukEventGetAll()),
        builder: (context, state) {
          return BlocListener<KategoriProdukBloc, KategoriProdukState>(
            listener: (context, state) {
              if (state is KategoriProdukStateSuccess) {
                context
                    .read<KategoriProdukBloc>()
                    .add(KategoriProdukEventGetAll());
              }

              if (state is KategoriProdukStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is KategoriProdukStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is KategoriProdukStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.kategoriProduks.length,
                        itemBuilder: (context, index) {
                          var kategori = state.kategoriProduks[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(kategori.namaKategori,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(kategori.deskripsi),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          final namaController =
                                              TextEditingController(
                                                  text: kategori.namaKategori);

                                          final deskripsiController =
                                              TextEditingController(
                                                  text: kategori.deskripsi);

                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Kategori',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                TextFormField(
                                                  controller:
                                                      deskripsiController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Deskripsi Kategori',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            KategoriProdukBloc>()
                                                        .add(
                                                          KategoriProdukEventEdit(
                                                            kategoriProdukModel:
                                                                KategoriProdukModel(
                                                              id: kategori.id,
                                                              namaKategori:
                                                                  namaController
                                                                      .text,
                                                              deskripsi:
                                                                  deskripsiController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label: const Text(
                                                      'Update Kategori'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context.read<KategoriProdukBloc>().add(
                                          KategoriProdukEventDelete(
                                              id: kategori.id));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('Tidak ada data')),
          );
        },
      ),
    );
  }
}
