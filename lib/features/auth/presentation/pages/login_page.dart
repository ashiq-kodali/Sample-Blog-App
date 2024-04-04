import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradiant_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../blog/presentation/pages/blog_page.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage(),);
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthFailure){
      showSnackBar(context, state.message);
    }
  },
  builder: (context, state) {
    if (state is AuthLoading){
      return const Loader();
    }
    return Form(
          child: Column(
            key:formKey ,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign In",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              AuthField(hintText: 'Email', controller: emailController,),
              const SizedBox(height: 10,),
              AuthField(hintText: 'Password', controller: passwordController,isObscureText: true,),
              const SizedBox(height: 20,),
               AuthGradiantButton(buttonText: 'Log In', onTap: () {
                 if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                   context.read<AuthBloc>().add(AuthLogin(email: emailController.text.trim(), password: passwordController.text.trim()));
                 }else if ( state is AuthSuccess){
                   Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false,);
                 }
                 
               },),
              const SizedBox(height: 25,),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,SignUpPage.route() );
                },
                child: RichText(
                  text:  TextSpan(text: 'Don\'t ',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient1,
                          fontWeight: FontWeight.bold
                      ),
                      children: [
                        TextSpan(text: 'Have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,),
                        TextSpan(text: 'Sign Up ',

                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppPallete.gradient2,
                              fontWeight: FontWeight.bold
                          ),)
                      ]
                  ),

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
