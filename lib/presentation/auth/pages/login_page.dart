import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/common/utils/validator/validator.dart';
import 'package:task_management/common/widgets/custom_snack_bar.dart';
import 'package:task_management/common/widgets/primary_button.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/routes/routes.dart';

import '../../../common/font/monserrat.dart';
import '../../../common/utils/status.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../core/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => GetIt.instance<AuthBloc>(),
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar(state.error ?? ''));
            } else if (state.status == Status.success) {
              Navigator.pushReplacementNamed(context, Routes.task);
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool(isLoggedIn, true);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Task Management 🚀',
                    style: Montserrat.bold.copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text('Sign in to get started',
                      style: Montserrat.medium.copyWith(fontSize: 18)),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextFormField(
                          labelText: 'Email',
                          hintText: 'Your email',
                          controller: emailController,
                          validator: Validator.validateEmail,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          labelText: 'Password',
                          hintText: 'Your password',
                          isPassword: true,
                          controller: passwordController,
                          validator: Validator.validatePassword,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    switch (state.status) {
                      case Status.loading:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      default:
                        return PrimaryButton(
                          text: 'Login',
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(LoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text));
                            }
                          },
                        );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
