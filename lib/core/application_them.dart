import 'package:flutter/material.dart';
import 'package:todo_app/core/app_color.dart';

class ApplicationThem{

static ThemeData lightthem= ThemeData(
  scaffoldBackgroundColor: AppColor.scaffoldbackground,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showUnselectedLabels: false,
    showSelectedLabels: false,
    selectedItemColor: AppColor.primarycolor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(
      size: 35,
  ),
    unselectedIconTheme: IconThemeData(
      size: 30,
    )
  ),
  iconTheme: IconThemeData(
    color: Colors.white
  ),
  textTheme: TextTheme(
   bodyLarge: TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'poppins',
  fontSize: 30,
),

    bodyMedium: TextStyle(

fontSize: 30,
fontWeight: FontWeight.w700,
fontFamily: 'poppins'),
     bodySmall: TextStyle(
       fontFamily: 'poppins',
       fontSize: 22,
         fontWeight: FontWeight.bold,
       color: AppColor.whitecolor
),
),
);
static ThemeData darkthem= ThemeData(
  scaffoldBackgroundColor: AppColor.scaffoldbackgrounddark,
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent
  )
  ,bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedItemColor: AppColor.primarycolor,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(
        size: 35,
      ),
      unselectedIconTheme: IconThemeData(
        size: 30,
      )
  ),
  iconTheme: IconThemeData(
      color: Colors.black
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'poppins',
      fontSize: 30,
    ),

    bodyMedium: TextStyle(

        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontFamily: 'poppins'),
    bodySmall: TextStyle(
        fontFamily: 'poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColor.blackcolor
    ),
  ),
);
}