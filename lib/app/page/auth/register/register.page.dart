import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app.metrics.dart';
import '../../../core/widgets/alert_dialog.widget.dart';
import '../../../core/widgets/header_register.widget.dart';
import '../../../core/widgets/step_indicator.widget.dart';
import '../../../core/widgets/text_field.widget.dart';
import 'register.controller.dart';
import 'register.state.dart';
import '../../../core/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
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
      },
      child: BlocBuilder<RegisterController, RegisterState>(
        builder: (context, state) {
          final controller = context.read<RegisterController>();
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    HeaderRegisterWidget(
                      title: 'Register',
                      onPressed: () {
                        controller.reset();
                        context.pop();
                      },
                    ),
                    StepIndicatorWidget(
                      currentStep: state.currentStep,
                      totalSteps: 2,
                      onStepTapped: (step) => controller.goToStep(step),
                      icons: [Icons.person_outline, Icons.lock_outline],
                    ),
                    Text(
                      _getStepTitle(state.currentStep),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Expanded(
                      child: _buildStep(
                        state.currentStep,
                        controller,
                        emailController,
                        passwordController,
                        confirmPasswordController,
                        nameController,
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          !_canAdvance(state.currentStep)
                              ? null
                              : () {
                                if (state.currentStep == 0) {
                                  controller.nextStep();
                                } else {
                                  controller.register(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                      child: Text(state.currentStep == 1 ? 'Finish' : 'Next'),
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

  bool _canAdvance(int currentStep) {
    if (currentStep == 0) {
      return Validators.validateEmail(emailController.text) == null &&
          Validators.validateName(nameController.text) == null;
    } else {
      return Validators.validatePassword(passwordController.text) == null &&
          Validators.confirmPassword(
                confirmPasswordController.text,
                passwordController.text,
              ) ==
              null;
    }
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Personal Data';
      case 1:
        return 'Password';
      default:
        return '';
    }
  }

  Widget _buildStep(
    int step,
    RegisterController controller,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    TextEditingController nameController,
  ) {
    switch (step) {
      case 0:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            child: Column(
              children: [
                TextFieldWidget(
                  controller: nameController,
                  label: 'Name',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: Validators.validateName,
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: AppMetrics.sizedBoxXS),
                TextFieldWidget(
                  controller: emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: Validators.validateEmail,
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Form(
            child: Column(
              children: [
                TextFieldWidget(
                  controller: passwordController,
                  label: 'Password',
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                  validator: Validators.validatePassword,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  isPassword: true,
                  validator:
                      (value) => Validators.confirmPassword(
                        value,
                        passwordController.text,
                      ),
                  onChanged: (_) => setState(() {}),
                ),
              ],
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
