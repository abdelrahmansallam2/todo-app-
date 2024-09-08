import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/provider/auth_user_provider.dart';

import '../../../provider/list_provider.dart';
import '../../../provider/settings_provider.dart';
class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {

  String tittle='';
  String description='';

  var selecteddate=DateTime.now();
  var Formkey= GlobalKey<FormState>();
  late ListProvider listprovider ;
  @override
  Widget build(BuildContext context) {
    var settingsprovider= Provider.of<SettingsProvider>(context);
     listprovider= Provider.of<ListProvider>(context);
    var them= Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color:  settingsprovider.isDark()?AppColor.blackcolor:AppColor.whitecolor,
        borderRadius: BorderRadius.circular(20),

      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
          right: 25,
          left: 25
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.add_new_task,
                style: them.textTheme.bodySmall?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:settingsprovider.isDark()?AppColor.whitecolor: AppColor.blackcolor
                ),
              textAlign: TextAlign.center,),
            SizedBox(height: 15,),

            Form(
              key: Formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (text){
                      tittle=text;
                    }
                    ,validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return'Enter Task Tittle ';
                      }
                      return null;
                    },
                    cursorColor: AppColor.primarycolor,
                    cursorHeight: 25,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:  settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                    ),

                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 12
                      ),
                      hintText: AppLocalizations.of(context)!.enter_your_task,
                      hintStyle: TextStyle(
                        color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.primarycolor,
                            width: 2
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height:25,),
                  TextFormField(
                      onChanged: (text){
                        description=text;
                      },
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return'Please Enter Task Description ';
                      }
                      return null;
                    },

                    cursorColor: AppColor.primarycolor,
                    cursorHeight: 25,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color:  settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                    ),

                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 12
                      ),
                      hintText: AppLocalizations.of(context)!.enter_task_des,
                      hintStyle: TextStyle(
                          color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.primarycolor,
                            width: 2
                        ),
                      ),
                    ),

                  ),
                  SizedBox(height: 15,),
                  Text(AppLocalizations.of(context)!.select_time,
                      style: them.textTheme.bodySmall?.copyWith(
                        color:settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 20
                      )),
                  SizedBox(height: 20,),

                  InkWell(
                    onTap: (){
                      showCalender();
                    },
                    child: Text('${selecteddate.day}/${selecteddate.month}/${selecteddate.year}',
                        textAlign: TextAlign.center,
                        style: them.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 18
                        )),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                          addTask();
                  },
                      child: Text(AppLocalizations.of(context)!.add_task,
                        style:TextStyle(
                          color: AppColor.whitecolor,
                          fontSize: 20
                        ) ,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primarycolor,
                   shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCalender() async{
  var chosendate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
  );
  selecteddate = chosendate ?? selecteddate;
  setState(() {

  });
  }
  void addTask(){
    if(Formkey.currentState!.validate()){

      Task task=Task(tittle: tittle,
          description: description,
          dateTime: selecteddate);
      var authprovider= Provider.of<AuthUserProvider>(context,listen: false);

          FirebaseUtils.addTaskToFireStore(task,authprovider.currentuser!.id!).then((onValue){
            Fluttertoast.showToast(
                msg: "Task added Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0
            );
              listprovider.getAllDataFromFireStore(authprovider.currentuser!.id!);
              Navigator.pop(context);
            });

    }

  }
}
