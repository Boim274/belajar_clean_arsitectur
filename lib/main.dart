import 'package:belajar_clean_arsitectur/core/routes/routes.dart';
import 'package:belajar_clean_arsitectur/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:belajar_clean_arsitectur/firebase_options.dart';
import 'package:belajar_clean_arsitectur/my_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
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
        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(
              produkUsecasesAdd: myinjection(),
              produkUsecasesDeleteProduk: myinjection(),
              produkUsecasesEditProduk: myinjection(),
              produkUsecasesGetAll: myinjection(),
              produkUsecasesGetById: myinjection()),
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
