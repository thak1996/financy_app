import 'package:financy_app/app/data/exports.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/utils/validators.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
import 'package:financy_app/app/page/auth/register/register.controller.dart';
import 'package:financy_app/app/page/auth/register/register.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
          context.pop();
          AlertDialogWidget.show(
            context,
            title: 'Erro',
            message: state.message,
          );
        }
        if (state is RegisterSuccess) context.goNamed('app-scaffold');
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
              padding: EdgeInsets.symmetric(horizontal: 22.sp, vertical: 16.sp),
              child: Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400.w),
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
                            ).textTheme.displayMedium?.copyWith(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Image.asset(
                          'assets/images/register.png',
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 32.h),
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
                              SizedBox(height: 24.h),
                              TextFieldWidget(
                                controller: _emailController,
                                label: 'YOUR EMAIL',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validateEmail,
                              ),
                              SizedBox(height: 24.h),
                              TextFieldWidget(
                                controller: _passwordController,
                                label: 'CHOOSE YOUR PASSWORD',
                                isPassword: true,
                                textInputAction: TextInputAction.next,
                                validator: Validators.validatePassword,
                                helperText:
                                    'Must have at least 8 characters, 1 capital letter and 1 number.',
                              ),
                              SizedBox(height: 24.h),
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
                        SizedBox(height: 16.h),
                        PrimaryButtonWidget(
                          padding: EdgeInsets.all(0),
                          text: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              controller.register(
                                UserModel(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name: _nameController.text,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 16.h),
                        TextRichWidget(
                          textOne: 'Already have account?',
                          textTwo: 'Sign in',
                          onTap: () => context.pushNamed('login'),
                        ),
                        SizedBox(height: 16.h),
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
