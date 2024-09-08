import 'dart:async';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/provider/settings_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
 @override
  void initState() {
 Timer(Duration(seconds: 2),
     (){
   Navigator.pushNamed(context, PageRoutesName.login);
     }

);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var settingsprovider=Provider.of<SettingsProvider>(context);
    return Image.asset( settingsprovider.isDark()?'assets/images/splash – 1.png'
        :'assets/images/splash_background.png',
      fit: BoxFit.cover,);
  }
}
