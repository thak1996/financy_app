import 'package:financy_app/app/data/exports.dart';
import 'package:financy_app/app/data/services/graphql.service.dart';
import 'package:financy_app/app/shared/consts/app_text_styles.dart';
import 'package:financy_app/app/shared/theme/app.colors.dart';
import 'package:financy_app/app/shared/utils/secure_storage.dart';
import 'package:financy_app/app/shared/utils/validators.dart';
import 'package:financy_app/app/shared/widgets/exports.dart';
import 'package:financy_app/app/page/auth/login/login.controller.dart';
import 'package:financy_app/app/page/auth/login/login.state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

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
          (context) => LoginController(
            authService: AuthFirebaseService(
              secureStorageService: SecureStorage(),
            ),
            graphQlService: GraphQlService(
              authService: AuthFirebaseService(
                secureStorageService: SecureStorage(),
              ),
            ),
          ),
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
                        padding: EdgeInsets.only(
                          right: 24.w,
                          left: 24.w,
                          bottom: 24.h,
                        ),
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              'Welcome Back',
                              style: AppTextStyles.text36(
                                context,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Image.asset('assets/images/login.png'),
                            SizedBox(height: 32.h),
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
                                  SizedBox(height: 37.h),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    label: 'YOUR PASSWORD',
                                    validator: Validators.validatePassword,
                                    isPassword: true,
                                  ),
                                  SizedBox(height: 8.h),
                                  TextRichWidget(
                                    textOne: 'Forgot Password?',
                                    alignment: Alignment.topRight,
                                    onTap: () {},
                                  ),
                                  SizedBox(height: 24.h),
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
                            SizedBox(height: 24.h),
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
