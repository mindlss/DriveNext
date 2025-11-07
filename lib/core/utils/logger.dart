// ignore_for_file: constant_identifier_names, unused_element

import 'package:flutter/foundation.dart';

const String _ANSI_RESET = '\x1B[0m';
const String _ANSI_RED = '\x1B[31m';
const String _ANSI_GREEN = '\x1B[32m';
const String _ANSI_YELLOW = '\x1B[33m';
const String _ANSI_BLUE = '\x1B[34m';
const String _ANSI_PURPLE = '\x1B[35m';
const String _ANSI_CYAN = '\x1B[36m';
const String _ANSI_WHITE = '\x1B[37m';

const String _ANSI_BRIGHT_RED = '\x1B[91m';
const String _ANSI_BRIGHT_GREEN = '\x1B[92m';
const String _ANSI_BRIGHT_YELLOW = '\x1B[93m';
const String _ANSI_BRIGHT_BLUE = '\x1B[94m';
const String _ANSI_BRIGHT_CYAN = '\x1B[96m';

void log(String message, {String tag = 'APP_LOG', String color = _ANSI_RESET}) {
  if (kDebugMode) {
    print('$color[$tag] $message$_ANSI_RESET');
  }
}

void logNetwork(String message, {String tag = 'NETWORK 📡'}) {
  log(message, tag: tag, color: _ANSI_BRIGHT_GREEN);
}
