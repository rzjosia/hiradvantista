import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiradvantista/src/utils/hive_db.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'src/app.dart';

Future<void> main() async {
  if (kDebugMode) {
    FlutterError.demangleStackTrace = (StackTrace stack) {
      if (stack is stack_trace.Trace) return stack.vmTrace;
      if (stack is stack_trace.Chain) {
        return stack
            .toTrace()
            .vmTrace;
      }
      return stack;
    };
  }

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await HiveDb().init();

  runApp(const ProviderScope(child: MyApp()));
}
