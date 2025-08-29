import 'package:logger/logger.dart';

import '../constants/app_constants.dart';

class AppLogger {
  static const logTag = "APP_LOGGER";
  static final Logger logger = Logger(
    printer: PrettyPrinter(
      // No stack trace lines
      methodCount: 0,
      // Stack trace lines for errors
      errorMethodCount: 5,
      // Very high, avoid truncation
      lineLength: 1000,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
    filter: _CustomLogFilter(),
  );
}

/// Custom filter based on `AppLogger.showLogs`
class _CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return AppConstants.showLogs;
  }
}