import 'package:drivenext/app/theme/colors.dart';
import 'package:drivenext/app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router/app_router.dart';
import '../../../core/network/network_manager.dart'; // подключаем менеджер

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // TODO: Инициализация приложения
    await Future.delayed(const Duration(milliseconds: 800));

    final bool hasConnection = await NetworkManager().checkConnection();

    if (!mounted) return;

    if (!hasConnection) {
      context.go(AppRoutes.noConnection);
      return;
    }

    // TODO: Авторизация
    const bool isAuthorized = false;

    if (isAuthorized) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 64),
            Text(
              'DriveNext',
              style: AppTypography.h2,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Text(
              'Поможем найти твою следующую поездку',
              style: AppTypography.h3.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.left,
            ),
            const Spacer(),
            Center(
              child: Image.asset(
                'assets/images/splash.png',
                width: 343,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
