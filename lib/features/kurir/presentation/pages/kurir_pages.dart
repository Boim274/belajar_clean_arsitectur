import 'package:belajar_clean_arsitectur/features/kurir/data/models/kurir_model.dart';
import 'package:belajar_clean_arsitectur/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KurirPages extends StatelessWidget {
  const KurirPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kurir Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  TextEditingController namaKurirController =
                      TextEditingController();
                  TextEditingController nomorTlpKurirController =
                      TextEditingController();
                  TextEditingController emailController =
                      TextEditingController();
                  TextEditingController kendaraanController =
                      TextEditingController();
                  TextEditingController statusController =
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
                          // Input Nama Kurir
                          TextFormField(
                            controller: namaKurirController,
                            decoration: const InputDecoration(
                              labelText: 'Nama Kurir',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Nama Kurir tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input nomorTlp Kurir
                          TextFormField(
                            controller: nomorTlpKurirController,
                            decoration: const InputDecoration(
                              labelText: ' Nomor Telephone',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'nomorTlp Kurir tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input email
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: ' Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input kendaraan
                          TextFormField(
                            controller: kendaraanController,
                            decoration: const InputDecoration(
                              labelText: 'Kendaraan',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Input status
                          TextFormField(
                            controller: statusController,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Status tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Tombol Simpan dengan validasi
                          BlocConsumer<KurirBloc, KurirState>(
                            listener: (context, state) {
                              if (state is KurirStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is KurirStateSuccess) {
                                context.pop();
                                context
                                    .read<KurirBloc>()
                                    .add(KurirEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    // Kirim event add jika form valid
                                    context.read<KurirBloc>().add(
                                          KurirEventAdd(
                                            kurirModel: KurirModel(
                                              id: '',
                                              namaKurir:
                                                  namaKurirController.text,
                                              nomorTlp:
                                                  nomorTlpKurirController.text,
                                              email: emailController.text,
                                              kendaraan:
                                                  kendaraanController.text,
                                              status: statusController.text,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                icon: state is KurirStateLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Icon(Icons.save),
                                label: const Text('Simpan Kurir'),
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
      body: BlocBuilder<KurirBloc, KurirState>(
        bloc: context.read<KurirBloc>()..add(KurirEventGetAll()),
        builder: (context, state) {
          return BlocListener<KurirBloc, KurirState>(
            listener: (context, state) {
              if (state is KurirStateSuccess) {
                context.read<KurirBloc>().add(KurirEventGetAll());
              }

              if (state is KurirStateError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: state is KurirStateLoading
                ? const Center(child: CircularProgressIndicator())
                : state is KurirStateLoadedAll
                    ? ListView.builder(
                        itemCount: state.kurirs.length,
                        itemBuilder: (context, index) {
                          var kurir = state.kurirs[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Text(kurir.namaKurir,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(kurir.email),
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
                                                  text: kurir.namaKurir);
                                          final nomorTlpController =
                                              TextEditingController(
                                                  text: kurir.nomorTlp);
                                          final emailController =
                                              TextEditingController(
                                                  text: kurir.email);
                                          final kendaraanController =
                                              TextEditingController(
                                                  text: kurir.kendaraan);
                                          final statusController =
                                              TextEditingController(
                                                  text: kurir.status);

                                          return Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextFormField(
                                                  controller: namaController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Nama Kurir',
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
                                                ),
                                                const SizedBox(height: 20),
                                                TextFormField(
                                                  controller: emailController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Email',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                TextFormField(
                                                  controller:
                                                      kendaraanController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Kendaraan',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                TextFormField(
                                                  controller: statusController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'status',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    context
                                                        .read<KurirBloc>()
                                                        .add(
                                                          KurirEventEdit(
                                                            kurirModel:
                                                                KurirModel(
                                                              id: kurir.id,
                                                              namaKurir:
                                                                  namaController
                                                                      .text,
                                                              nomorTlp:
                                                                  nomorTlpController
                                                                      .text,
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              kendaraan:
                                                                  kendaraanController
                                                                      .text,
                                                              status:
                                                                  statusController
                                                                      .text,
                                                            ),
                                                          ),
                                                        );
                                                    Navigator.pop(context);
                                                  },
                                                  icon:
                                                      const Icon(Icons.update),
                                                  label: const Text(
                                                      'Update Kurir'),
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
                                      context
                                          .read<KurirBloc>()
                                          .add(KurirEventDelete(id: kurir.id));
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
