import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/moduls/tasks/widgets/task_item_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/settings_provider.dart';
import '../../model/task.dart';
import '../../provider/list_provider.dart';

class TasksView extends StatefulWidget {
  TasksView({super.key});


  @override
  State<TasksView> createState() => _TasksViewState();
  
}

class _TasksViewState extends State<TasksView> {

  final EasyInfiniteDateTimelineController _controller =
  EasyInfiniteDateTimelineController();
  var _focusDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    var listprovider= Provider.of<ListProvider>(context);
    var authprovider= Provider.of<AuthUserProvider>(context);
    var settingsprovider= Provider.of<SettingsProvider>(context);

if(listprovider.tasklist.isEmpty){
 listprovider.getAllDataFromFireStore(authprovider.currentuser!.id!);
}
    var mediaquary=MediaQuery.of(context);
    return Column(
      children: [
     Padding(
       padding: EdgeInsets.only(bottom: 50),
       child: Stack(
         clipBehavior: Clip.none,
         children: [
           Container(
             width: mediaquary.size.width,
             height: mediaquary.size.height *.22,
             color: AppColor.primarycolor,
             child: Padding(
               padding: EdgeInsets.only(
                 left: 20,
               ),
               child: Row(
                 children: [
                   Text(AppLocalizations.of(context)!.todo_list,
                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                     color: settingsprovider.isDark()?AppColor.blackcolor:AppColor.whitecolor
                   ),),
                   SizedBox(width: mediaquary.size.width*.5,),
                   IconButton(onPressed: (){
                     listprovider.tasklist=[];
                   Navigator.pushReplacementNamed(context, PageRoutesName.login);
                   }, icon: Icon(Icons.logout))
                 ],
               ),
             ),
           ),
           Positioned(
             top: 130
             ,child: SizedBox(
               width: mediaquary.size.width,
               child: EasyInfiniteDateTimeLine(
                 controller: _controller,
                 firstDate: DateTime(2024),
                 focusDate: listprovider.selectDate,
                 lastDate: DateTime(2025, 12, 31),
                 onDateChange: (selectedDate) {
                   listprovider.changeSelectedDate(selectedDate,authprovider.currentuser!.id!);
                   setState(() {
                     _focusDate = selectedDate;
                   });
                 },
                 dayProps: EasyDayProps(
                   activeDayStyle: DayStyle(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                        color:AppColor.whitecolor.withOpacity(.85)
                     ),
                     dayNumStyle:  TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'poppins',
                       fontSize: 15,
                       color: AppColor.primarycolor
                     ),
                     monthStrStyle:  TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'poppins',
                       fontSize: 15,
                       color:  AppColor.primarycolor
                     ),dayStrStyle: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'poppins',
                       fontSize: 15,
                       color:  AppColor.primarycolor
                   ),
                   ),
                   inactiveDayStyle: DayStyle(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: settingsprovider.isDark()?AppColor.blackcolor.withOpacity(.85): AppColor.whitecolor.withOpacity(.85),

                     ),
                     dayNumStyle:  TextStyle(
                         fontWeight: FontWeight.bold,
                         fontFamily: 'poppins',
                         fontSize: 15,
                         color:settingsprovider.isDark()?AppColor.whitecolor :AppColor.blackcolor
                     ),
                     monthStrStyle:  TextStyle(
                         fontWeight: FontWeight.bold,
                         fontFamily: 'poppins',
                         fontSize: 15,
                         color: settingsprovider.isDark()?AppColor.whitecolor :AppColor.blackcolor
                     ),dayStrStyle: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontFamily: 'poppins',
                       fontSize: 15,
                       color: settingsprovider.isDark()?AppColor.whitecolor :AppColor.blackcolor
                   ),
                   ),
                 ),
                 showTimelineHeader: false,
               ),
             ),
           ),
         ],
       ),
       
     ),
        Expanded(child:
        ListView.builder(padding: EdgeInsets.zero,
          itemBuilder:(context,index)=> TaskItemWidget(model:listprovider.tasklist[index],)
          ,itemCount: listprovider.tasklist.length,))
        ]
    );
  }

}
