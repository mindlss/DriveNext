import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/theme/app_theme.dart';

import 'features/auth/login/login_screen.dart';

// TODO: Роутер
// import 'app/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveNext',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),

      // Пока что просто первый экран
      home: const LoginScreen(),
    );
  }
}
