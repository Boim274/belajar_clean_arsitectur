import 'package:belajar_clean_arsitectur/features/produk/presentation/pages/produk_pages.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  get router => GoRouter(
    initialLocation:
    '/'
    ,
        // myinjection<FirebaseAuth>().currentUser == null ||
        //         myinjection<Box>().get('user') == null
        //     ? UrlAppConstant.login
        //     : UrlAppConstant.home,
    // redirect: (context, state) async {
    //   String? path;
    //   myinjection<FirebaseAuth>().authStateChanges().listen((User? user) {
    //     if (user == null) {
    //       path = UrlAppConstant.login;
    //     } else {
    //       path = null;
    //       // myinjection<AuthBloc>().add(
    //       //   AuthEventGetCurrentUser(uid: myinjection<Box>().get('user')['id']),
    //       // );
    //     }
    //   });
    //   return path == null && myinjection<Box>().get('user') == null
    //       ? path
    //       : null;
    // },
    routes: [
      // GoRoute(
      //   path: UrlAppConstant.onboarding,
      //   name: MenuConstants.onboarding,
      //   pageBuilder:
      //       (context, state) => NoTransitionPage(child: OnboardingPage()),
      // ),
      // GoRoute(
      //   path: UrlAppConstant.login,
      //   name: MenuConstants.login,
      //   pageBuilder: (context, state) => NoTransitionPage(child: LoginPage()),
      //   routes: [
      //     GoRoute(
      //       path: UrlAppConstant.login + UrlAppConstant.register,
      //       name: MenuConstants.register,
      //       pageBuilder:
      //           (context, state) => NoTransitionPage(
      //             child: RegisterPage(
      //               onLoginClicked: () {
      //                 context.go(UrlAppConstant.login);
      //               },
      //             ),
      //           ),
      //     ),
      //     GoRoute(
      //       path: UrlAppConstant.login + UrlAppConstant.forgotPassword,
      //       name: MenuConstants.forgotPassword,
      //       pageBuilder:
      //           (context, state) => NoTransitionPage(
      //             child: ForgotPasswordPage(
      //               onLoginClicked: () {
      //                 context.pushNamed(MenuConstants.login);
      //               },
      //             ),
      //           ),
      //     ),
      //   ],
      // ),
      GoRoute(
        path: '/',
        name: 'produk',
        pageBuilder: (context, state) => NoTransitionPage(child: ProdukPages()),
      ),
      // GoRoute(
      //   path: UrlAppConstant.produk,
      //   name: MenuConstants.produk,
      //   pageBuilder: (context, state) => NoTransitionPage(child: ProdukPage()),
      //   routes: [
      //     GoRoute(
      //       path: UrlAppConstant.produk + UrlAppConstant.detailProduk,
      //       name: MenuConstants.detailProduk,
      //       builder: (context, state) {
      //         return DetailProdukPage(produk: state.extra as ProdukModel);
      //       },
      //     ),
      //   ],
      // ),
    ],
  );
}