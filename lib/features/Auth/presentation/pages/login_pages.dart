import 'package:belajar_clean_arsitectur/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: email,
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: password,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go('/register');
                },
                child: Text('register'),
              )
            ],
          ),
          SizedBox(height: 15),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is AuthStateLoaded) {
                context.go('/produk');
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthEventLogin(
                        email: email.text, password: password.text));
                  },
                  child: Text(state is AuthStateLoading ? 'Loading' : 'Login'));
            },
          ),
        ],
      ),
    );
  }
}
