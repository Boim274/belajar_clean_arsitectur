import 'package:belajar_clean_arsitectur/core/components/cubit/option/option_cubit.dart';
import 'package:belajar_clean_arsitectur/core/routes/routes.dart';
import 'package:belajar_clean_arsitectur/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:belajar_clean_arsitectur/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:belajar_clean_arsitectur/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:belajar_clean_arsitectur/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:belajar_clean_arsitectur/firebase_options.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initializeDateFormatting('id_ID', null);
  // await Hive.initFlutter();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OptionCubit>(
          create: (context) => OptionCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            signInWithEmail: myinjection(),
            registerWithEmail: myinjection(),
          ),
        ),
        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(
              produkUsecasesAdd: myinjection(),
              produkUsecasesDeleteProduk: myinjection(),
              produkUsecasesEditProduk: myinjection(),
              produkUsecasesGetAll: myinjection(),
              produkUsecasesGetById: myinjection()),
        ),
        BlocProvider<KategoriProdukBloc>(
          create: (context) => KategoriProdukBloc(
              kategoriProdukUsecaseAdd: myinjection(),
              kategoriProdukUsecaseEdit: myinjection(),
              kategoriProdukUsecaseDelete: myinjection(),
              kategoriProdukUsecaseGetAll: myinjection(),
              kategoriProdukUsecaseGetById: myinjection()),
        ),
        BlocProvider<JenisProdukBloc>(
          create: (context) => JenisProdukBloc(
              jenisUsecaseAddJenis: myinjection(),
              jenisUsecaseEditJenis: myinjection(),
              jenisUsecaseDeleteJenis: myinjection(),
              jenisUsecaseGetAll: myinjection(),
              jenisUsecaseGetById: myinjection()),
        ),
        BlocProvider<SuplierBloc>(
          create: (context) => SuplierBloc(
              suplierUsecaseAdd: myinjection(),
              suplierUsecaseEdit: myinjection(),
              suplierUsecaseDelete: myinjection(),
              suplierUsecaseGetAll: myinjection(),
              suplierUsecaseGetById: myinjection()),
        ),
        BlocProvider<GudangBloc>(
          create: (context) => GudangBloc(
              gudangUsecaseAdd: myinjection(),
              gudangUsecaseEdit: myinjection(),
              gudangUsecaseDelete: myinjection(),
              gudangUsecaseGetAll: myinjection(),
              gudangUsecaseGetById: myinjection()),
        ),
        BlocProvider<KurirBloc>(
          create: (context) => KurirBloc(
              kurirUsecaseAdd: myinjection(),
              kurirUsecaseEdit: myinjection(),
              kurirUsecaseDelete: myinjection(),
              kurirUsecaseGetAll: myinjection(),
              kurirUsecaseGetById: myinjection()),
        ),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        color: Colors.white,
        // theme: AppThemes.light,
        // darkTheme: AppTheme.dark,
        routerConfig: MyRouter().router,
        // routerDelegate: AutoRouterDelegate(router),
        // routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
