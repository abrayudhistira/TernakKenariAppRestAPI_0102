import 'package:canary_template/presentation/auth/bloc/register/bloc/register_bloc.dart';
import 'package:canary_template/core/components/components.dart';
import 'package:canary_template/core/components/spaces.dart';
import 'package:canary_template/core/constants/colors.dart';
import 'package:canary_template/core/core.dart';
import 'package:canary_template/data/model/request/auth/registerRequestModel.dart';
import 'package:canary_template/views/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController namaController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _key;
  bool isShowPassword = false;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(100),
                Text('Daftar Akun Baru',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SpaceHeight(30),
                CustomTextField(
                  validator: 'Nama tidak boleh kosong',
                  controller: namaController,
                  label: 'Username',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.person),
                  ),
                ),
                const SpaceHeight(25),
                CustomTextField(
                  validator: 'Email tidak boleh kosong',
                  controller: emailController,
                  label: 'Email',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.email),
                  ),
                ),
                const SpaceHeight(25),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        validator: 'Password tidak boleh kosong',
                        controller: passwordController,
                        label: 'Password',
                        obscureText: !isShowPassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.lock),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                          icon: Icon(
                            isShowPassword ? Icons.visibility : Icons.visibility_off,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SpaceHeight(50),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      context.pushAndRemoveUntil(
                        const LoginScreen(),
                        (route) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: AppColors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Button.filled(
                      onPressed: state is RegisterLoading
                          ? null
                          : () {
                              if (_key.currentState!.validate()) {
                                final request = RegisterRequestModel(
                                  username: namaController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  roleId: 2,
                                );
                                context.read<RegisterBloc>().add(
                                  RegisterRequested(requestModel: request),
                                );
                              }
                            },
                      label: state is RegisterLoading ? 'Memuat...' : 'Daftar Akun Baru',
                    );
                  },
                ),
                const SpaceHeight(20),
                Text.rich(
                  TextSpan(
                    text: 'Sudah punya akun? ',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: AppColors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: 'Login Disini!',
                        style: TextStyle(
                          color: AppColors.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushAndRemoveUntil(
                              const LoginScreen(),
                              (route) => false,
                            );
                          },
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}