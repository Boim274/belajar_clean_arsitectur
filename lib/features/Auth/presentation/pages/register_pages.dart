import 'package:belajar_clean_arsitectur/core/components/cubit/option/option_cubit.dart';
import 'package:belajar_clean_arsitectur/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPages extends StatelessWidget {
  const RegisterPages({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buat Akun',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Harap isi semua form untuk Register',
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
                        // username form
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // email form
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
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
                              controller: passwordController,
                              obscureText: state,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
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
                                hintText: 'Password',
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ character.'
                                    : null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        // konfirmasi password form
                        BlocBuilder<OptionCubit, bool>(
                          builder: (context, state) {
                            return TextFormField(
                              controller: confirmPasswordController,
                              obscureText: state,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock_outline),
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
                                hintText: 'Confirm Password',
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ character.'
                                    : null;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              context.go('/');
                            },
                            child: Text(
                              'Sudah punya akun? Login',
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
                      context.go('/');
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventRegister(
                                name: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          state is AuthStateLoading
                              ? 'Registering...'
                              : 'Register',
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
