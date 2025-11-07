import '../../app/router/app_router.dart';
import 'network_service.dart';

import '../utils/logger.dart';

class NetworkManager {
  NetworkManager._internal();
  static final NetworkManager _instance = NetworkManager._internal();
  factory NetworkManager() => _instance;

  String? _lastRoute;

  // Маршруты, которые при восстановлении сети должны вести на другой
  final Map<String, String> _routeRedirects = {
    '/rent': '/cars', // пример: если пользователь был на аренде
  };

  bool _wasDisconnected = false;

  Future<void> init() async {
    await NetworkService().initialize(onStatusChange: _handleConnectionChange);

    final isConnected = NetworkService().isConnected;
    if (!isConnected) {
      _wasDisconnected = true;
      logNetwork('Started offline mode');
    }
  }

  void _handleConnectionChange(bool isConnected) {
    if (!isConnected) {
      _wasDisconnected = true;
      _saveCurrentRoute();
      appRouter.go('/no-connection');
      logNetwork('Connection lost, saved route: $_lastRoute');
    } else {
      if (_wasDisconnected) {
        _wasDisconnected = false;
        _restoreLastRoute();
      }
    }
  }

  void _saveCurrentRoute() {
    final location =
        appRouter.routerDelegate.currentConfiguration.last.matchedLocation;
    if (location != '/no-connection') {
      _lastRoute = location;
    }
  }

  void _restoreLastRoute() {
    if (_lastRoute == null) {
      appRouter.go('/');
      return;
    }

    final redirectRoute = _routeRedirects[_lastRoute];
    if (redirectRoute != null) {
      appRouter.go(redirectRoute);
      logNetwork('Redirected $_lastRoute → $redirectRoute');
    } else {
      appRouter.go(_lastRoute!);
      logNetwork('Restored route: $_lastRoute');
    }
  }

  Future<bool> checkConnection() async {
    final service = NetworkService();
    final isConnected = await service.hasConnection();
    logNetwork('Checked connection: $isConnected');
    return isConnected;
  }
}
