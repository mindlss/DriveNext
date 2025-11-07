import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/theme/app_theme.dart';
import 'app/router/app_router.dart';
import 'core/network/network_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация сервисов (синглтонов)
  await NetworkManager().init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DriveNext',
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      routerConfig: appRouter,
    );
  }
}
