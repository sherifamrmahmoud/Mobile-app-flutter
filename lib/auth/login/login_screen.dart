import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/cubit/auth_state.dart';
import 'package:nti5/auth/signup/signup_screen.dart';
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
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login Success")));

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/home');
            });
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,

                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),

                    child: IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.06),

                        child: Form(
                          key: formKey,

                          child: Column(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.02),

                                    Center(
                                      child: Image.asset(
                                        'assets/small_logo.png',
                                        width: size.width * 0.2,
                                        height: size.width * 0.2,
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.01),

                                    Center(
                                      child: Text(
                                        'Welcome Back',
                                        style: TextStyle(
                                          fontSize: size.width * 0.08,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.01),

                                    Center(
                                      child: Text(
                                        'Please log in to manage your consultations.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: size.width * 0.035,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.04),

                                    Text(
                                      'Email Address',
                                      style: TextStyle(
                                        fontSize: size.width * 0.04,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),

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

                                    SizedBox(height: size.height * 0.02),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Password',
                                          style: TextStyle(
                                            fontSize: size.width * 0.04,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    CustomTextFormField(
                                      hint: 'Enter your password',
                                      controller: passwordController,
                                      prefixIcon: Icons.lock_outline,
                                      obscure: true,
                                      suffix: const Icon(
                                        Icons.visibility_outlined,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password is required";
                                        }
                                        return null;
                                      },
                                    ),

                                    SizedBox(height: size.height * 0.03),

                                    SizedBox(
                                      width: double.infinity,
                                      height: size.height * 0.07,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        onPressed: state is AuthLoading
                                            ? null
                                            : () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  context
                                                      .read<AuthCubit>()
                                                      .login(
                                                        emailController.text,
                                                        passwordController.text,
                                                      );
                                                }
                                              },
                                        child: state is AuthLoading
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2,
                                                    ),
                                              )
                                            : Text(
                                                'Log In',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: size.width * 0.045,
                                                ),
                                              ),
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.02),

                                    Center(
                                      child: Text(
                                        'Or continue with',
                                        style: TextStyle(
                                          fontSize: size.width * 0.035,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: size.height * 0.02),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.g_mobiledata,
                                            ),
                                            label: Text(
                                              'Google',
                                              style: TextStyle(
                                                fontSize: size.width * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.04),
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                            ),
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.apple,
                                              color: Colors.white,
                                            ),
                                            label: Text(
                                              'Apple',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width * 0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // bottom signup ثابت بدون overflow
                              Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('New here? '),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignupScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Create an account',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
