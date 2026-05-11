import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/cubit/auth_state.dart';
import 'package:nti5/auth/widgets/SnackBarHelper%20.dart';

import 'package:nti5/auth/widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    nameController.dispose();
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
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/small_logo.png',
              width: size.width * 0.1,
              height: size.width * 0.1,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              'MEDI CALL',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            SnackBarHelper.success(context, "Account Created");

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }

          if (state is AuthError) {
            SnackBarHelper.error(context, state.message);
          }
        },

        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.06),

              child: SingleChildScrollView(
                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Join the MEDI CALL community and manage your healthcare journey with ease and efficiency.',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),

                      const SizedBox(height: 30),

                      // NAME
                      const Text('Full Name'),
                      const SizedBox(height: 8),

                      CustomTextFormField(
                        hint: 'Enter your full name',
                        controller: nameController,
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // EMAIL
                      const Text('Email Address'),
                      const SizedBox(height: 8),

                      CustomTextFormField(
                        hint: 'name@example.com',
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

                      const SizedBox(height: 15),

                      // PASSWORD
                      const Text('Password'),
                      const SizedBox(height: 8),

                      CustomTextFormField(
                        hint: 'Create a secure password',
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
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      // BUTTON
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

                                    context.read<AuthCubit>().signUp(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
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
                                  "Create Account",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
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
