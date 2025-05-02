import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/utils/secure_storage.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/text_button.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import 'login.controller.dart';
import 'login.state.dart';
import '../../../core/widgets/alert_dialog.widget.dart';

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
      create: (context) => LoginController(SecureStorageService()),
      child: BlocBuilder<LoginController, LoginState>(
        builder: (context, state) {
          final controller = context.read<LoginController>();
          return BlocListener<LoginController, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                AlertDialogWidget.show(
                  context,
                  title: 'Erro',
                  message: state.message,
                );
              }
              if (state is LoginSuccess) context.go('/home');
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
                              style: Theme.of(context).textTheme.displayLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
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
                                  TextButtonWidget(
                                    alignment: Alignment.topRight,
                                    primaryText: 'Forgot Password?',
                                    primaryTextColor: AppColors.link,
                                    onPressed: () {},
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                            FilledButton(
                              onPressed:
                                  state is LoginLoading
                                      ? null
                                      : () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          controller.login(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                        }
                                      },
                              child:
                                  state is LoginLoading
                                      ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : const Text('Sign In'),
                            ),
                            const SizedBox(height: 24),
                            TextButtonWidget(
                              primaryText: 'Don\'t Have Account?',
                              secondaryText: 'Sign up',
                              onPressed: () => context.push('/register'),
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
