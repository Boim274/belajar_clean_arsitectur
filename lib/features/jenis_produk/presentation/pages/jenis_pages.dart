import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/data/models/jenis_model.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class JenisPages extends StatelessWidget {
  const JenisPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Pages'),
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
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  TextEditingController namaJenisController =
                      TextEditingController();
                  TextEditingController deskripsiJenisController =
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
                          // Input Nama Jenis
                          TextFormField(
                            controller: namaJenisController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Jenis',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Jenis tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input Deskripsi Jenis
                          TextFormField(
                            controller: deskripsiJenisController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi Jenis',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Deskripsi Jenis tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Tombol Simpan dengan validasi
                          BlocConsumer<JenisProdukBloc, JenisProdukState>(
                            listener: (context, state) {
                              if (state is JenisProdukStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is JenisProdukStateSuccess) {
                                context.pop();
                                context
                                    .read<JenisProdukBloc>()
                                    .add(JenisEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<JenisProdukBloc>().add(
                                          JenisEventAdd(
                                            jenisModel: JenisModel(
                                              id: '',
                                              namaJenis:
                                                  namaJenisController.text,
                                              deskripsi:
                                                  deskripsiJenisController.text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is JenisProdukStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Jenis'),
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
      drawer: CustomDrawer(),
      body: BlocBuilder<JenisProdukBloc, JenisProdukState>(
        bloc: context.read<JenisProdukBloc>()..add(JenisEventGetAll()),
        builder: (context, state) {
          return BlocListener<JenisProdukBloc, JenisProdukState>(
            listener: (context, state) {
              if (state is JenisProdukStateSuccess) {
                context.read<JenisProdukBloc>().add(JenisEventGetAll());
              }

              if (state is JenisProdukStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is JenisProdukStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is JenisProdukStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.jenis.length,
                        itemBuilder: (context, index) {
                          var jenis = state.jenis[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(jenis.namaJenis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(jenis.deskripsi),
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
                                                  text: jenis.namaJenis);

                                          final deskripsiController =
                                              TextEditingController(
                                                  text: jenis.deskripsi);

                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Jenis',
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
                                                        'Deskripsi Jenis',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<JenisProdukBloc>()
                                                        .add(
                                                          JenisEventEdit(
                                                            jenisModel:
                                                                JenisModel(
                                                              id: jenis.id,
                                                              namaJenis:
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
                                                      'Update Jenis'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                   icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Konfirmasi'),
                                          content: const Text(
                                              'Yakin ingin menghapus jenis ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(), // Tutup dialog
                                              child: const Text('Tidak'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<JenisProdukBloc>()
                                                    .add(
                                                      JenisEventDelete(
                                                          id: jenis.id),
                                                    );
                                                Navigator.of(context)
                                                    .pop(); // Tutup dialog setelah hapus
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // context
                                      //     .read<JenisProdukBloc>()
                                      //     .add(JenisEventDelete(id: jenis.id));
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
