import 'package:belajar_clean_arsitectur/core/components/custom-drawer.dart';
import 'package:belajar_clean_arsitectur/features/gudang/data/models/gudang_model.dart';
import 'package:belajar_clean_arsitectur/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GudangPages extends StatelessWidget {
  const GudangPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gudang Pages'),
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
                  TextEditingController namaGudangController =
                      TextEditingController();
                  TextEditingController alamatGudangController =
                      TextEditingController();
                  TextEditingController nomorTlpGudangController =
                      TextEditingController();
                  TextEditingController kapasitasGudangController =
                      TextEditingController();
                  String? selectedValueSuplierId;
                  // Form Key untuk validasi
                  final formKey = GlobalKey<FormState>();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Input Nama Gudang
                          TextFormField(
                            controller: namaGudangController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Gudang',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Gudang tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Input Alamat
                          TextFormField(
                            controller: alamatGudangController,
                            decoration: const InputDecoration(
                              labelText: 'Alamat',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Alamat Gudang tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Input nomorTlp Gudang
                          TextFormField(
                            controller: nomorTlpGudangController,
                            decoration: const InputDecoration(
                              labelText: 'Nomor Telephone',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // hanya angka
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'nomorTlp Gudang tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Input Kapasitas
                          TextFormField(
                            controller: kapasitasGudangController,
                            decoration: const InputDecoration(
                              labelText: 'Kapasistas',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kapasitas Gudang tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Dropdown Suplier
                          BlocBuilder<SuplierBloc, SuplierState>(
                            bloc: context.read<SuplierBloc>()
                              ..add(SuplierEventGetAll()),
                            builder: (context, state) {
                              if (state is SuplierStateError) {
                                return Text(state.message);
                              }
                              if (state is SuplierStateLoadedAll) {
                                final suplier = state.supliers;

                                return DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Suplier',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: selectedValueSuplierId,
                                  items: suplier
                                      .map(
                                        (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(e.namaSuplier)),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    selectedValueSuplierId = value;
                                  },
                                  // validasi
                                  validator: (value) => value == null
                                      ? 'Suplier wajib dipilih'
                                      : null,
                                );
                              }
                              // Saat loading
                              return const CircularProgressIndicator();
                            },
                          ),
                          const SizedBox(height: 20),
                          // Tombol Simpan dengan validasi
                          BlocConsumer<GudangBloc, GudangState>(
                            listener: (context, state) {
                              if (state is GudangStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is GudangStateSuccess) {
                                context.pop();
                                context
                                    .read<GudangBloc>()
                                    .add(GudangEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<GudangBloc>().add(
                                          GudangEventAdd(
                                            gudangModel: GudangModel(
                                              id: '',
                                              suplierId: selectedValueSuplierId,
                                              namaGudang:
                                                  namaGudangController.text,
                                              alamat:
                                                  alamatGudangController.text,
                                              nomorTlp:
                                                  nomorTlpGudangController.text,
                                              kapasitas:
                                                  kapasitasGudangController
                                                      .text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is GudangStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Gudang'),
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
      body: BlocBuilder<GudangBloc, GudangState>(
        bloc: context.read<GudangBloc>()..add(GudangEventGetAll()),
        builder: (context, state) {
          return BlocListener<GudangBloc, GudangState>(
            listener: (context, state) {
              if (state is GudangStateSuccess) {
                context.read<GudangBloc>().add(GudangEventGetAll());
              }

              if (state is GudangStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is GudangStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is GudangStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.gudangs.length,
                        itemBuilder: (context, index) {
                          var gudang = state.gudangs[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(gudang.namaGudang,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Alamat: ${gudang.alamat}'),
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
                                                  text: gudang.namaGudang);
                                          final alamatController =
                                              TextEditingController(
                                                  text: gudang.alamat);
                                          final nomorTlpController =
                                              TextEditingController(
                                                  text: gudang.nomorTlp);
                                          final kapasitasController =
                                              TextEditingController(
                                                  text: gudang.kapasitas);
                                          String? selectedValueSuplierId =
                                              gudang.suplierId;
                                          context
                                              .read<SuplierBloc>()
                                              .add(SuplierEventGetAll());
                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // edit nama gudang
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Gudang',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                // edit alamat
                                                TextFormField(
                                                  controller: alamatController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Alamat',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                // edit nomo tlp
                                                TextFormField(
                                                  controller:
                                                      nomorTlpController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Nomor telephone',
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
                                                const SizedBox(height: 20),
                                                // edit kapasistas
                                                TextFormField(
                                                  controller:
                                                      kapasitasController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Kapasistas',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),

                                                // Dtropdown edit suplier
                                                BlocBuilder<SuplierBloc,
                                                    SuplierState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is SuplierStateError) {
                                                      return Text(
                                                          state.message);
                                                    }

                                                    if (state
                                                        is SuplierStateLoadedAll) {
                                                      final suplier =
                                                          state.supliers;

                                                      return DropdownButtonFormField<
                                                          String>(
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: 'Suplier',
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                        value:
                                                            selectedValueSuplierId, // nilai awal diisi untuk edit
                                                        items: suplier.map((e) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: e.id,
                                                            child: Text(
                                                                e.namaSuplier),
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          selectedValueSuplierId =
                                                              value;
                                                        },
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'Suplier wajib dipilih'
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
                                                        .read<GudangBloc>()
                                                        .add(
                                                          GudangEventEdit(
                                                            gudangModel:
                                                                GudangModel(
                                                              id: gudang.id,
                                                              suplierId:
                                                                  selectedValueSuplierId,
                                                              namaGudang:
                                                                  namaController
                                                                      .text,
                                                              alamat:
                                                                  alamatController
                                                                      .text,
                                                              nomorTlp:
                                                                  nomorTlpController
                                                                      .text,
                                                              kapasitas:
                                                                  kapasitasController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label: const Text(
                                                      'Update Gudang'),
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
                                              'Yakin ingin menghapus gudang ini?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(), // Tutup dialog
                                              child: const Text('Tidak'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<GudangBloc>().add(
                                                      GudangEventDelete(
                                                          id: gudang.id),
                                                    );
                                                Navigator.of(context)
                                                    .pop(); // Tutup dialog setelah hapus
                                              },
                                              child: const Text('Ya'),
                                            ),
                                          ],
                                        ),
                                      );
                                      // context.read<GudangBloc>().add(
                                      //     GudangEventDelete(id: gudang.id));
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
