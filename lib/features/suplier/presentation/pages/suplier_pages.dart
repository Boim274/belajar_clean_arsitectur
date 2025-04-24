import 'package:belajar_clean_arsitectur/features/suplier/data/models/suplier_model.dart';
import 'package:belajar_clean_arsitectur/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SuplierPages extends StatelessWidget {
  const SuplierPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suplier Pages'),
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
                  TextEditingController namaSuplierController =
                      TextEditingController();
                  TextEditingController alamatController =
                      TextEditingController();
                  TextEditingController nomorTlpSuplierController =
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
                          // Input Nama Suplier
                          TextFormField(
                            controller: namaSuplierController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Suplier',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Suplier tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input Alamat
                          TextFormField(
                            controller: alamatController,
                            decoration: const InputDecoration(
                              labelText: 'Alamat',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Alamat tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input nomorTlp Suplier
                          TextFormField(
                            controller: nomorTlpSuplierController,
                            decoration: const InputDecoration(
                              labelText: ' Nomor Telephone',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, // hanya angka
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'nomorTlp Suplier tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Tombol Simpan dengan validasi
                          BlocConsumer<SuplierBloc, SuplierState>(
                            listener: (context, state) {
                              if (state is SuplierStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is SuplierStateSuccess) {
                                context.pop();
                                context
                                    .read<SuplierBloc>()
                                    .add(SuplierEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<SuplierBloc>().add(
                                          SuplierEventAdd(
                                            suplierModel: SuplierModel(
                                              id: '',
                                              namaSuplier:
                                                  namaSuplierController.text,
                                              alamat: alamatController.text,
                                              nomorTlp:
                                                  nomorTlpSuplierController
                                                      .text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is SuplierStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Suplier'),
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
      body: BlocBuilder<SuplierBloc, SuplierState>(
        bloc: context.read<SuplierBloc>()..add(SuplierEventGetAll()),
        builder: (context, state) {
          return BlocListener<SuplierBloc, SuplierState>(
            listener: (context, state) {
              if (state is SuplierStateSuccess) {
                context.read<SuplierBloc>().add(SuplierEventGetAll());
              }

              if (state is SuplierStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is SuplierStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is SuplierStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.supliers.length,
                        itemBuilder: (context, index) {
                          var suplier = state.supliers[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(suplier.namaSuplier,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text('Alamat: ${suplier.alamat}'),
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
                                                  text: suplier.namaSuplier);
                                          final alamatController =
                                              TextEditingController(
                                                  text: suplier.alamat);
                                          final nomorTlpController =
                                              TextEditingController(
                                                  text: suplier.nomorTlp);

                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Suplier',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
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
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<SuplierBloc>()
                                                        .add(
                                                          SuplierEventEdit(
                                                            suplierModel:
                                                                SuplierModel(
                                                              id: suplier.id,
                                                              namaSuplier:
                                                                  namaController
                                                                      .text,
                                                              alamat:
                                                                  alamatController
                                                                      .text,
                                                              nomorTlp:
                                                                  nomorTlpController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label: const Text(
                                                      'Update Suplier'),
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
                                      context.read<SuplierBloc>().add(
                                          SuplierEventDelete(id: suplier.id));
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
