import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/moduls/layout_view.dart';
import 'package:todo_app/moduls/login/login_view.dart';
import 'package:todo_app/moduls/registration/registration_view.dart';
import 'package:todo_app/moduls/splash/splash_view.dart';
import 'package:todo_app/moduls/tasks/widgets/edit_task.dart';

class RoutesGenerator{

  static Route<dynamic> onGenerateRoutes(RouteSettings settings){

    switch(settings.name){
      case PageRoutesName.initial:
        return MaterialPageRoute(builder: (context)=>SplashView(),
          settings: settings,
        );
      case PageRoutesName.login:
        return MaterialPageRoute(builder: (context)=>LoginView(),
        settings: settings
        );
      case PageRoutesName.registration:
        return MaterialPageRoute(builder: (context)=>RegistrationView(),
          settings: settings,

        );
      case PageRoutesName.layout:
        return MaterialPageRoute(builder: (context)=>LayoutView(),
          settings: settings,

        );
      case PageRoutesName.edit:
        return MaterialPageRoute(builder: (context)=>EditTask(),
          settings: settings,

        );
      default :
        return MaterialPageRoute(builder: (context)=>SplashView(),
          settings: settings,
        );
    }

  }
}