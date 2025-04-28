import 'package:belajar_clean_arsitectur/core/components/cubit/option/option_cubit.dart';
import 'package:belajar_clean_arsitectur/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPages extends StatelessWidget {
  const LoginPages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'silahkan login untuk masuk aplikasi',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // email form
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'email@mail.com',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // password form
                        BlocBuilder<OptionCubit, bool>(
                          builder: (context, state) {
                            return TextFormField(
                              controller: password,
                              obscureText: state,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<OptionCubit>().change();
                                  },
                                  icon: Icon(
                                    state
                                        ? Icons.visibility_off_outlined
                                        : Icons.remove_red_eye_outlined,
                                  ),
                                ),
                                hintText: 'password...',
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ character.'
                                    : null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              context.go('/register');
                            },
                            child: Text(
                              'Tidak punya akun? Register',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is AuthStateLoaded) {
                      context.go('/produk');
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventLogin(
                              email: email.text, password: password.text));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          state is AuthStateLoading ? 'Loading...' : 'Login',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
