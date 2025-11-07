import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

typedef ConnectionChangedCallback = void Function(bool isConnected);

class NetworkService {
  NetworkService._internal();
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  ConnectionChangedCallback? _onStatusChange;

  bool _isConnected = true;

  bool get isConnected => _isConnected;

  Future<void> initialize({ConnectionChangedCallback? onStatusChange}) async {
    _onStatusChange = onStatusChange;

    // Первичная проверка
    _isConnected = await _checkInternet();

    // Подписка на изменения соединения
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      bool hasConnection = !results.contains(ConnectivityResult.none);

      if (hasConnection) {
        hasConnection = await _checkInternet();
      }

      if (_isConnected != hasConnection) {
        _isConnected = hasConnection;
        _onStatusChange?.call(hasConnection);
      }
    });
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
  }

  Future<bool> _checkInternet() async {
    try {
      //TODO: Проверка подключения к бэку
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<bool> hasConnection() async {
    if (_isConnected) return true;

    final connected = await _checkInternet();
    _isConnected = connected;
    return connected;
  }
}
