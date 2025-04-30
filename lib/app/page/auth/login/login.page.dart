import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/theme/app.metrics.dart';
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
                            const Spacer(flex: 1),
                            Icon(
                              Icons.security,
                              size: 64,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: AppMetrics.sizedBoxM),
                            Text(
                              'Welcome Back',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            SizedBox(height: AppMetrics.sizedBoxM),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextFieldWidget(
                                    controller: _emailController,
                                    label: 'Email',
                                    validator: Validators.validateEmail,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        value,
                                        _passwordController.text,
                                      );
                                    },
                                  ),
                                  SizedBox(height: AppMetrics.sizedBoxXS),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    label: 'Password',
                                    validator: Validators.validatePassword,
                                    isPassword: true,
                                    onChanged: (value) {
                                      controller.validateFields(
                                        _emailController.text,
                                        value,
                                      );
                                    },
                                  ),
                                  SizedBox(height: AppMetrics.sizedBoxXXS),
                                  TextButtonWidget(
                                    alignment: Alignment.topRight,
                                    primaryText: 'Forgot Password?',
                                    primaryTextColor: AppColors.link,
                                    onPressed: () {},
                                  ),
                                  SizedBox(height: AppMetrics.sizedBoxM),
                                ],
                              ),
                            ),
                            const Spacer(),
                            FilledButton(
                              onPressed:
                                  state is LoginLoading || !state.isValid
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
                                      : const Text('Login'),
                            ),
                            SizedBox(height: AppMetrics.sizedBoxXS),
                            TextButtonWidget(
                              primaryText: 'Don\'t have an account?',
                              secondaryText: 'Sign up',
                              primaryTextColor: AppColors.textPrimary,
                              secondaryTextColor: AppColors.link,
                              onPressed: () => context.push('/register'),
                            ),
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
