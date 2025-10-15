import 'package:flutter/material.dart';

// Импорт твоей темы
import 'app/theme/app_theme.dart';

// Импорт стартового экрана (например, экран входа)
import 'features/auth/login/login_screen.dart';

// Если используешь router — можешь позже заменить стартовый экран на router
// import 'app/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveNext', // или название твоего приложения
      debugShowCheckedModeBanner: false,

      // Применяем кастомную тему
      theme: getAppTheme(),

      // Если потом добавишь dark theme — просто добавь сюда:
      // darkTheme: getAppDarkTheme(),
      // themeMode: ThemeMode.system,

      // Пока что просто первый экран
      home: const LoginScreen(),
    );
  }
}
