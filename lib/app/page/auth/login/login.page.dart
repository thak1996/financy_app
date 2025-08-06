import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/auth_firebase.service.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/utils/secure_storage.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/text_field.widget.dart';
import '../../../core/widgets/text_rich_widget.dart';
import 'login.controller.dart';
import 'login.state.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';

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
          (context) => LoginController(SecureStorage(), AuthFirebaseService()),
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
              if (state is LoginSuccess) context.goNamed('home');
              if (state is LoginLoading) {
                showDialog(
                  context: context,
                  builder:
                      (context) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      ),
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
                            PrimaryButton(
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
