import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:window_size/window_size.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'app/di.dart';
import 'constants/app_color.dart';
import 'service/google_sign_in_api.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  await setupLocator();
  GoogleSignInService.initialize();
  runApp(const MyApp());

  if (!kIsWeb && !(Platform.isIOS || Platform.isAndroid)) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setWindowMinSize(const Size(400, 600));
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TS Screen User',
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.splashPage,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.appBarStart),
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        useMaterial3: true,
      ),
    );
  }
}
