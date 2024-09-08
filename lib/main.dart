import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/application_them.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/core/routes_generator.dart';
import 'package:todo_app/moduls/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/list_provider.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>ListProvider()),
    ChangeNotifierProvider(create: (context)=>AuthUserProvider()),
    ChangeNotifierProvider(create: (context)=>SettingsProvider())
  ],child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var settingsprovider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ApplicationThem.lightthem,
      darkTheme: ApplicationThem.darkthem,
      initialRoute: PageRoutesName.initial,
      onGenerateRoute: RoutesGenerator.onGenerateRoutes,
      locale: Locale(settingsprovider.currentlanguge),
      themeMode: settingsprovider.currentthemmode,
    );
  }
}


