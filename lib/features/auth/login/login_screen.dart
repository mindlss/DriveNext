import 'package:drivenext/app/widgets/app_filled_button.dart';
import 'package:drivenext/app/widgets/app_text_button.dart';
import 'package:drivenext/app/widgets/app_text_field.dart';
import 'package:drivenext/app/theme/colors.dart';
import 'package:drivenext/app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFieldKey = GlobalKey<AppTextFieldState>();
  final _passwordFieldKey = GlobalKey<AppTextFieldState>();

  void _onLogin() {
    final isEmailValid = _emailFieldKey.currentState?.isValid() ?? false;
    final isPasswordValid = _passwordFieldKey.currentState?.isValid() ?? false;

    if (isEmailValid && isPasswordValid) {
      // TODO: Авторизация
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Авторизация...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Войдите в аккаунт',
                  style: AppTypography.h2.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Пожалуйста, введите свои данные',
                  style: AppTypography.h3.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),

                AppTextField(
                  label: 'Электронная почта',
                  hint: 'Введите электронную почту',
                  key: _emailFieldKey,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле является обязательным';
                    }
                    if (!value.contains('@')) {
                      return 'Некорректный email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                AppTextField(
                  label: 'Пароль',
                  hint: 'Введите пароль',
                  key: _passwordFieldKey,
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Это поле является обязательным';
                    }
                    if (value.length < 6) {
                      return 'Минимум 6 символов';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                AppTextButton(
                  text: 'Забыли пароль?',
                  onPressed: () {
                    //TODO: Восстановление пароля;
                  },
                ),

                const SizedBox(height: 32),

                AppFilledButton(
                  label: 'Войти',
                  style: FilledButtonStyle.primary,
                  onPressed: _onLogin,
                ),

                const SizedBox(height: 16),

                AppFilledButton(
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    width: 20,
                    height: 20,
                  ),
                  label: 'Войти через Google',
                  style: FilledButtonStyle.social,
                  onPressed: () {
                    //TODO: Авторизация Google;
                  },
                ),
                const SizedBox(height: 64),
                AppTextButton(
                  text: 'Зарегистрироваться',
                  onPressed: () {
                    //TODO: Регистрация;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
