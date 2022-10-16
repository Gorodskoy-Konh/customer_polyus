import 'package:customer_web/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Stem',
      ),
      //home: const NewOrderPage(restorationId: 'main',),
      home: const AuthPage(),
    );
  }
}
