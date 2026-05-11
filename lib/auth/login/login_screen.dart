import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/cubit/auth_state.dart';
import 'package:nti5/auth/signup/signup_screen.dart';
import 'package:nti5/auth/widgets/SnackBarHelper%20.dart';
import 'package:nti5/auth/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.05,
          ),
        ),
        centerTitle: true,
      ),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            SnackBarHelper.success(context, "Login Success");

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/home');
            });
          }

          if (state is AuthError) {
            SnackBarHelper.error(context, state.message);
          }
        },

        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

              child: Padding(
                padding: EdgeInsets.all(size.width * 0.06),

                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.03),

                      Center(
                        child: Image.asset(
                          'assets/small_logo.png',
                          width: size.width * 0.2,
                          height: size.width * 0.2,
                        ),
                      ),

                      SizedBox(height: 10),

                      Center(
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: size.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 5),

                      Center(
                        child: Text(
                          'Login to continue',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // EMAIL
                      const Text('Email Address'),
                      SizedBox(height: 8),

                      CustomTextFormField(
                        hint: 'user@gmail.com',
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 20),

                      // PASSWORD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Password'),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),

                      CustomTextFormField(
                        hint: 'Enter your password',
                        controller: passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscure: !isPasswordVisible,

                        suffix: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30),

                      // LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();

                                    context.read<AuthCubit>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },

                          child: state is AuthLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Log In",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Center(
                        child: Text(
                          "New here?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: const Text(
                            "Create an account",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
