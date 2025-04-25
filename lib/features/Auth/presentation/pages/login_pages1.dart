import 'package:belajar_clean_arsitectur/core/components/cubit/option/option_cubit.dart';
import 'package:belajar_clean_arsitectur/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPages1 extends StatelessWidget {
  LoginPages1({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Form Email
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'email@mail.com',
              labelText: 'Email',
            ),
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
          const SizedBox(
            height: 24,
          ),

          // Form Password
          BlocBuilder<OptionCubit, bool>(
            builder: (context, state) {
              return TextFormField(
                controller: password,
                obscureText: state,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<OptionCubit>().change();
                    },
                    icon: Icon(state == true
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined),
                  ),
                  icon: const Icon(Icons.lock),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? 'Do not use the @ char.'
                      : null;
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          //   BlocConsumer<AuthBloc, AuthState>(
          //     listener: (context, state) {
          //       if (state is AuthStateError) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text(state.message),
          //       duration: const Duration(seconds: 3),
          //     ),
          //   );
          // } else if (state is AuthStateLoaded) {
          //   context.go('/'); // Navigate to home page on success
          // }
          //     },
          //     builder: (context, state) {
          //       return ElevatedButton(onPressed: state is Aut, child: );
          //     },
          //   )
          // Button Login
          SizedBox(
            height: 50,
            width: double.infinity,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStateError) {
                  return Text(state.message);
                }
                return InkWell(
                  onTap: () {
                    context.read<AuthBloc>().add(AuthEventLogin(
                        email: email.text, password: password.text));
                  },
                  child: Container(
                    width: 150,
                    height: 50, // Tinggi diperbesar biar kelihatan
                    alignment: Alignment.center, // Pastikan teks di tengah
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
