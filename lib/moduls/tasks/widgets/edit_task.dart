import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';

import '../../../firebase_utils.dart';
import '../../../model/task.dart';
import '../../../provider/auth_user_provider.dart';
import '../../../provider/list_provider.dart';
import '../../../provider/settings_provider.dart';

class EditTask extends StatefulWidget {
   EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  var selecteddate=DateTime.now();
  late ListProvider listprovider ;


  @override
  Widget build(BuildContext context) {
    var settingsprovider=Provider.of<SettingsProvider>(context);
    var authprovider=Provider.of<AuthUserProvider>(context);
  var model=ModalRoute.of(context)!.settings.arguments as Task;
    var them=Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.primarycolor,
        title: Text('Edit Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Card(
          color: settingsprovider.isDark()?AppColor.blackcolor:AppColor.whitecolor  ,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
            Container(
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
                  Text('Edit Task',
                    style: them.textTheme.bodySmall?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                    ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 15,),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                     initialValue: model.tittle,
                       onChanged: (text){
                          model.tittle=text;
                        }
                        ,
                        cursorColor: AppColor.primarycolor,
                        cursorHeight: 25,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                        ),
            
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 12
                          ),
                          hintText: 'Task Name',
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
                        initialValue: model.description
                        ,onChanged: (text){
            
                          model.description=text;
                        },
            
                        cursorColor: AppColor.primarycolor,
                        cursorHeight: 25,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                        ),
            
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 12
                          ),
                          hintText: 'Task Describtion',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColor.primarycolor,
                                width: 2
                            ),
                          ),
                        ),
            
                      ),
                      SizedBox(height: 15,),
                      Text('Select Time',
                          style: them.textTheme.bodySmall?.copyWith(
                              color:settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor,
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                          )),
                      SizedBox(height: 20,),
            
                      InkWell(
                        onTap: ()async{
                       DateTime? newdate=await showCalender();
                       if(newdate!=null){
                         selecteddate=newdate.millisecondsSinceEpoch as DateTime;
                         setState(() {
            
                         });
                       }
            
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
                      ElevatedButton(
                        onPressed: (){
                        FirebaseUtils.updateTask(model,authprovider.currentuser!.id! );
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Task Edeted Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      },
                        child: Text('Save Changes',
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
                ],
              ),
            ),
            
            )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showCalender() async{
     DateTime? chosendate = await showDatePicker(
       context: context,
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)),
     );
if(chosendate!=null){
  selecteddate=chosendate;
  setState(() {

  });
}
return chosendate;
   }

}

