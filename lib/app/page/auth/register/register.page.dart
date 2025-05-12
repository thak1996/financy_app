import '../../../core/models/user_credentials.model.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/primary_button.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app.colors.dart';
import '../../../core/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/text_rich_widget.dart';
import 'register.controller.dart';
import 'register.state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          AlertDialogWidget.show(
            context,
            title: 'Erro',
            message: state.message,
          );
        }
        if (state is RegisterSuccess) context.go('/home');
        if (state is RegisterLoading) {
          showDialog(
            context: context,
            builder:
                (context) => Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                ),
          );
        }
      },
      child: BlocBuilder<RegisterController, RegisterState>(
        builder: (context, state) {
          final controller = context.read<RegisterController>();
          return Scaffold(
            backgroundColor: AppColors.iceWhite,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Start Saving\nYour Money!',
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Image.asset('assets/images/register.png'),
                        const SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldWidget(
                                controller: _nameController,
                                label: 'YOUR NAME',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validateName,
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                controller: _emailController,
                                label: 'YOUR EMAIL',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validateEmail,
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                controller: _passwordController,
                                label: 'CHOOSE YOUR PASSWORD',
                                isPassword: true,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validatePassword,
                                helperText:
                                    'Must have at least 8 characters, 1 capital letter and 1 number.',
                              ),
                              const SizedBox(height: 24),
                              TextFieldWidget(
                                controller: _confirmPasswordController,
                                label: 'CONFIRM YOUR PASSWORD',
                                isPassword: true,
                                validator:
                                    (value) => Validators.confirmPassword(
                                      value,
                                      _passwordController.text,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          padding: const EdgeInsets.all(0),
                          text: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.register(
                                UserCredentials(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name: _nameController.text,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        TextRichWidget(
                          textOne: 'Already have account?',
                          textTwo: 'Sign in',
                          onTap: () => context.push('/login'),
                        ),
                        const SizedBox(height: 16),
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
  }
}
