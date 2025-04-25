import 'package:belajar_clean_arsitectur/features/Auth/presentation/pages/login_pages1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // TextEditingController usernameController = TextEditingController();
    // TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          // form username
          // TextFormField(
          //   controller: usernameController,
          // ),
          const SizedBox(height: 15),
          //form email
          TextFormField(
            controller: emailController,
          ),
          const SizedBox(height: 15),
          //form password
          TextFormField(
            controller: passwordController,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/');
                },
                child: Text('Login'),
              )
            ],
          ),

          const SizedBox(height: 15),
          // //form konfirmasi password
          // TextFormField(
          //   controller: confirmPasswordController,
          // ),
          const SizedBox(height: 15),
          // button register
          ElevatedButton(onPressed: () {}, child: const Text('Register'))
        ],
      ),
    );
  }
}
