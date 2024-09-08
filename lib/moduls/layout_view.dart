import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/moduls/settings/settings_view.dart';
import 'package:todo_app/moduls/tasks/Tasks_View.dart';
import 'package:todo_app/moduls/tasks/widgets/task_bottom_sheet.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../provider/settings_provider.dart';

class LayoutView extends StatefulWidget {
LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
int selectedindex=0;

List<Widget>screens=[
  TasksView(),SettingsView(),
];

  @override
  Widget build(BuildContext context) {
    var settingsprovider=Provider.of<SettingsProvider>(context);
    var listprovider=Provider.of<ListProvider>(context);
    var authprovider=Provider.of<AuthUserProvider>(context);
    return Scaffold(
      extendBody: true,
        body: screens[selectedindex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        backgroundColor: settingsprovider.isDark()?AppColor.scaffoldbackgrounddark:AppColor.whitecolor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),

      ),
        onPressed: (){
        showAddTaskBottomSheet();

        },

        child:CircleAvatar(
          backgroundColor: AppColor.primarycolor,
          child: Icon(Icons.add,
          color: AppColor.whitecolor,
          size: 30,),
          radius: 25,
        ) ,),

      bottomNavigationBar:
      BottomAppBar(
        height: 93,
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        color: settingsprovider.isDark()?AppColor.bottomnavbardark: AppColor.whitecolor,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex:selectedindex ,
            onTap: (value){
             setState(() {
               selectedindex=value;
             });
            },
            items: [
          BottomNavigationBarItem(icon:Icon(Icons.list),
              label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
              label:'Settings'),

        ]),
      )
    );
  }
  void showAddTaskBottomSheet(){
    showModalBottomSheet(context: context,
        builder: (context)=>TaskBottomSheet());
  }
}
