import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Config/app_config.dart';
import 'Constants/providers_list.dart';
import 'Screens/main_screen.dart';
import 'Themes/app_default_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersList.getProviders(),
      child: MaterialApp(
        title: AppConfig.app_name,
        theme: appDefaultTheme(),
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
