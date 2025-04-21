import 'package:belajar_clean_arsitectur/features/produk/data/models/produk_model.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController namaProdukController =
                        TextEditingController();
                    TextEditingController hargaProdukController =
                        TextEditingController();
                    TextEditingController deskripsiProdukController =
                        TextEditingController();
                    return Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: namaProdukController,
                          ),
                          TextFormField(
                            controller: hargaProdukController,
                          ),
                          TextFormField(
                            controller: deskripsiProdukController,
                          ),
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
                              return IconButton(
                                  onPressed: () {
                                    context.read<ProdukBloc>().add(
                                        ProdukEventAdd(
                                            produkModel: ProdukModel(
                                                id: '',
                                                namaProduk:
                                                    namaProdukController.text,
                                                harga:
                                                    hargaProdukController.text,
                                                deskripsi:
                                                    deskripsiProdukController
                                                        .text)));
                                  },
                                  icon: state is ProdukStateLoading
                                      ? Text('Loading...')
                                      : Icon(Icons.save));
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.plus_one))
        ],
      ),
      body: BlocConsumer<ProdukBloc, ProdukState>(
        bloc: context.read<ProdukBloc>()..add(ProdukEventGetAll()),
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProdukStateLoadedAll) {
            return ListView.builder(
              itemCount: state.produks.length,
              itemBuilder: (context, index) {
                var produk = state.produks[index];
                return ListTile(
                  title: Text(produk.namaProduk),
                  subtitle: Text(produk.harga),
                );
              },
            );
          }
          if (state is ProdukStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
