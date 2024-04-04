import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradiant_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blog/presentation/pages/blog_page.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthFailure){
       showSnackBar(context, state.message);
    }else if ( state is AuthSuccess){
      Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false,);
    }
  },
  builder: (context, state) {
    if (state is AuthLoading){
      return const Loader();
    }
    return Form(
          child: Column(
            key: formKey,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(
                height: 10,
              ),
              AuthField(
                hintText: 'Email',
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                isObscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              AuthGradiantButton(
                buttonText: 'Sign Up',
                onTap: () {
                  if (nameController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
                    context.read<AuthBloc>().add(AuthSignUp(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    LoginPage.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Already ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient1,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'Have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: 'Sign In ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              )
            ],
          ),
        );
  },
),
      ),
    );
  }
}
