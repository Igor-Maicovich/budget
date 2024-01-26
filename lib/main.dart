import 'dart:async';

import 'package:my_budget/src/core/utils/logger.dart';
import 'package:my_budget/src/feature/app/logic/app_runner.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    ),
    const LogOptions(),
  );
}
