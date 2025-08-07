import 'package:financy_app/app/core/services/auth_firebase.service.dart';
import 'package:financy_app/app/core/theme/app.colors.dart';
import 'package:financy_app/app/core/utils/secure_storage.dart';
import 'package:financy_app/app/core/utils/validators.dart';
import 'package:financy_app/app/core/widgets/exports.dart';
import 'package:financy_app/app/page/auth/login/login.controller.dart';
import 'package:financy_app/app/page/auth/login/login.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => LoginController(AuthFirebaseService(SecureStorage())),
      child: BlocBuilder<LoginController, LoginState>(
        builder: (context, state) {
          final controller = context.read<LoginController>();
          return BlocListener<LoginController, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                context.pop();
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is LoginSuccess) context.goNamed('app-scaffold');
              if (state is LoginLoading) {
                showDialog(
                  context: context,
                  builder: (context) => CircularProgressIndicatorWidget(),
                );
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.iceWhite,
              body: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 24,
                          left: 24,
                          bottom: 24,
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              'Welcome Back',
                              style: Theme.of(
                                context,
                              ).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Image.asset('assets/images/login.png'),
                            const SizedBox(height: 32),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    controller: _emailController,
                                    label: 'YOUR EMAIL',
                                    validator: Validators.validateEmail,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  const SizedBox(height: 37),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    label: 'YOUR PASSWORD',
                                    validator: Validators.validatePassword,
                                    isPassword: true,
                                  ),
                                  const SizedBox(height: 8),
                                  TextRichWidget(
                                    textOne: 'Forgot Password?',
                                    alignment: Alignment.topRight,
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            PrimaryButtonWidget(
                              padding: const EdgeInsets.all(0),
                              text: 'Sign In',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            TextRichWidget(
                              textOne: 'Don\'t Have Account?',
                              textTwo: 'Sign up',
                              onTap: () => context.pushNamed('register'),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
