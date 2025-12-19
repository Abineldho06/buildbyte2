import 'dart:io';

import 'package:build_byte/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:build_byte/ui/tools/screen_size.dart';
import 'package:build_byte/app/app.locator.dart';
import 'package:build_byte/app/app.router.dart';
import 'package:build_byte/constants/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!kIsWeb) {
    if (Platform.isAndroid) {
      // Android specific logic (optional)
    }
  }

  setupDependencies();
  runApp(const MyApp());
}

Future<void> setupDependencies() async {
  setupLocator();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFBF1)),
      title: AppStrings.appName,

      builder: (context, child) {
        ScreenSize.init(context);

        return FlutterSmartDialog.init()(
          context,
          MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1)),
            child: child!,
          ),
        );
      },

      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        StackedService.routeObserver,
        FlutterSmartDialog.observer,
      ],
    );
  }
}
