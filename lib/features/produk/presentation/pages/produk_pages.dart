import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
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
                  TextEditingController namaProdukController =
                      TextEditingController();
                  TextEditingController hargaProdukController =
                      TextEditingController();
                  TextEditingController deskripsiProdukController =
                      TextEditingController();
                  String? selectedValueCategoryId;
                  String? selectedValueJenisId;
                  String? selectedValueGudangId;
                  // Form Key untuk validasi
                  final formKey = GlobalKey<FormState>();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input Nama Produk
                          TextFormField(
                            controller: namaProdukController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Produk',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama produk tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input Harga Produk
                          TextFormField(
                            controller: hargaProdukController,
                            decoration: const InputDecoration(
                              labelText: 'Harga Produk',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // hanya angka
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Harga produk tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input Deskripsi Produk
                          TextFormField(
                            controller: deskripsiProdukController,
                            decoration: const InputDecoration(
                              labelText: 'Deskripsi Produk',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Deskripsi produk tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Dropdown Kategori produk
                          BlocBuilder<KategoriProdukBloc, KategoriProdukState>(
                            bloc: context.read<KategoriProdukBloc>()
                              ..add(KategoriProdukEventGetAll()),
                            builder: (context, state) {
                              if (state is KategoriProdukStateError) {
                                return Text(state.message);
                              }
                              if (state is KategoriProdukStateLoadedAll) {
                                final kategori = state.kategoriProduks;

                                return DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Kategori',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedValueCategoryId,
                                  items: kategori
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.namaKategori)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValueCategoryId = value;
                                  },
                                  // validasi
                                  validator: (value) => value == null
                                      ? 'Kategori wajib dipilih'
                                      : null,
                                );
                              }
                              // Saat loading
                              return const CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 20),

                          // Dropdown jenis produk
                          BlocBuilder<JenisProdukBloc, JenisProdukState>(
                            bloc: context.read<JenisProdukBloc>()
                              ..add(JenisEventGetAll()),
                            builder: (context, state) {
                              if (state is JenisProdukStateError) {
                                return Text(state.message);
                              }
                              if (state is JenisProdukStateLoadedAll) {
                                final jenis = state.jenis;

                                return DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Jenis',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedValueJenisId,
                                  items: jenis
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.namaJenis)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValueJenisId = value;
                                  },
                                  // validasi
                                  validator: (value) => value == null
                                      ? 'Jenis wajib dipilih'
                                      : null,
                                );
                              }
                              // Saat loading
                              return const CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 20),

                          // Dropdown gudang
                          BlocBuilder<GudangBloc, GudangState>(
                            bloc: context.read<GudangBloc>()
                              ..add(GudangEventGetAll()),
                            builder: (context, state) {
                              if (state is GudangStateError) {
                                return Text(state.message);
                              }
                              if (state is GudangStateLoadedAll) {
                                final gudang = state.gudangs;
                                return DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Gudang',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedValueGudangId,
                                  items: gudang
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.namaGudang)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValueGudangId = value;
                                  },
                                  // validasi
                                  validator: (value) => value == null
                                      ? 'Gudang wajib dipilih'
                                      : null,
                                );
                              }
                              // Saat loading
                              return const CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 20),

                          // Tombol Simpan dengan validasi
                          BlocConsumer<ProdukBloc, ProdukState>(
                            listener: (context, state) {
                              if (state is ProdukStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is ProdukStateSuccess) {
                                context.pop();
                                context
                                    .read<ProdukBloc>()
                                    .add(ProdukEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<ProdukBloc>().add(
                                          ProdukEventAdd(
                                            produkModel: ProdukModel(
                                              id: '',
                                              kategoriId:
                                                  selectedValueCategoryId,
                                              jenisId: selectedValueJenisId,
                                              gudangId: selectedValueGudangId,
                                              namaProduk:
                                                  namaProdukController.text,
                                              harga: hargaProdukController.text,
                                              deskripsi:
                                                  deskripsiProdukController
                                                      .text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is ProdukStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Produk'),
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
      body: BlocBuilder<ProdukBloc, ProdukState>(
        bloc: context.read<ProdukBloc>()..add(ProdukEventGetAll()),
        builder: (context, state) {
          return BlocListener<ProdukBloc, ProdukState>(
            listener: (context, state) {
              if (state is ProdukStateSuccess) {
                context.read<ProdukBloc>().add(ProdukEventGetAll());
              }

              if (state is ProdukStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is ProdukStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is ProdukStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.produks.length,
                        itemBuilder: (context, index) {
                          var produk = state.produks[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(produk.namaProduk,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Rp ${produk.harga}'),
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
                                                  text: produk.namaProduk);
                                          final hargaController =
                                              TextEditingController(
                                                  text: produk.harga);
                                          final deskripsiController =
                                              TextEditingController(
                                                  text: produk.deskripsi);
                                          String? selectedValueKategoryId =
                                              produk.kategoriId;
                                          String? selectedValueJenisId =
                                              produk.jenisId;
                                          String? selectedValueGudangId =
                                              produk.gudangId;
                                          // penmbahan context agar bisa terbaca
                                          context
                                              .read<KategoriProdukBloc>()
                                              .add(KategoriProdukEventGetAll());
                                          context
                                              .read<JenisProdukBloc>()
                                              .add(JenisEventGetAll());
                                          context
                                              .read<GudangBloc>()
                                              .add(GudangEventGetAll());

                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // nama produk
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Produk',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),

                                                // harga produk
                                                TextFormField(
                                                  controller: hargaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Harga Produk',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly, // hanya angka
                                                  ],
                                                ),
                                                const SizedBox(height: 16),

                                                // deskripsi
                                                TextFormField(
                                                  controller:
                                                      deskripsiController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Deskripsi Produk',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),

                                                // dropdown Kategori produk
                                                BlocBuilder<KategoriProdukBloc,
                                                    KategoriProdukState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is KategoriProdukStateError) {
                                                      return Text(
                                                          state.message);
                                                    }

                                                    if (state
                                                        is KategoriProdukStateLoadedAll) {
                                                      final kategori =
                                                          state.kategoriProduks;

                                                      return DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Kategori',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        value:
                                                            selectedValueKategoryId, // nilai awal diisi untuk edit
                                                        items:
                                                            kategori.map((e) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: e.id,
                                                            child: Text(
                                                                e.namaKategori),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          selectedValueKategoryId =
                                                              value;
                                                        },
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'Kategori wajib dipilih'
                                                                : null,
                                                      );
                                                    }

                                                    return const CircularProgressIndicator();
                                                  },
                                                ),
                                                const SizedBox(height: 20),

                                                // dropdown jenis produk
                                                BlocBuilder<JenisProdukBloc,
                                                    JenisProdukState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is JenisProdukStateError) {
                                                      return Text(
                                                          state.message);
                                                    }

                                                    if (state
                                                        is JenisProdukStateLoadedAll) {
                                                      final jenis = state.jenis;

                                                      return DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Jenis',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        value:
                                                            selectedValueJenisId, // nilai awal diisi untuk edit
                                                        items: jenis.map((e) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: e.id,
                                                            child: Text(
                                                                e.namaJenis),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          selectedValueJenisId =
                                                              value;
                                                        },
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'Jenis wajib dipilih'
                                                                : null,
                                                      );
                                                    }

                                                    return const CircularProgressIndicator();
                                                  },
                                                ),
                                                const SizedBox(height: 20),

                                                // dropdown gudang
                                                BlocBuilder<GudangBloc,
                                                    GudangState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is GudangStateError) {
                                                      return Text(
                                                          state.message);
                                                    }

                                                    if (state
                                                        is GudangStateLoadedAll) {
                                                      final gudang =
                                                          state.gudangs;

                                                      return DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Gudang',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        value:
                                                            selectedValueGudangId, // nilai awal diisi untuk edit
                                                        items: gudang.map((e) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: e.id,
                                                            child: Text(
                                                                e.namaGudang),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          selectedValueGudangId =
                                                              value;
                                                        },
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'Gudang wajib dipilih'
                                                                : null,
                                                      );
                                                    }

                                                    return const CircularProgressIndicator();
                                                  },
                                                ),
                                                const SizedBox(height: 20),

                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<ProdukBloc>()
                                                        .add(
                                                          ProdukEventEdit(
                                                            produkModel:
                                                                ProdukModel(
                                                              id: produk.id,
                                                              kategoriId:
                                                                  selectedValueKategoryId,
                                                              jenisId:
                                                                  selectedValueJenisId,
                                                              gudangId:
                                                                  selectedValueGudangId,
                                                              namaProduk:
                                                                  namaController
                                                                      .text,
                                                              harga:
                                                                  hargaController
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
                                                      'Update Produk'),
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
                                      context.read<ProdukBloc>().add(
                                          ProdukEventDelete(id: produk.id));
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
