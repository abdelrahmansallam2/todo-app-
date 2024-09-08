import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/app_color.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/list_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/provider/settings_provider.dart';
class TaskItemWidget extends StatefulWidget {



 Task model;
 TaskItemWidget({required this.model});
  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    var them=Theme.of(context);
var listprovider= Provider.of<ListProvider>(context);
    var authprovider= Provider.of<AuthUserProvider>(context);
    var settingsprovider=Provider.of<SettingsProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Slidable(
        startActionPane: ActionPane(

          extentRatio: .38,
          motion:  DrawerMotion(),

          children:[
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context){
                FirebaseUtils.deleteTaskFromFireStore(widget.model,authprovider.currentuser!.id!).
                then((onValue){
                  Fluttertoast.showToast(
                      msg: "Task Deleted Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16
                  );
                  listprovider.getAllDataFromFireStore(authprovider.currentuser!.id!);
                });
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context){
                Navigator.pushNamed(context, PageRoutesName.edit,
                arguments: widget.model);
                FirebaseUtils.updateTask(widget.model,authprovider.currentuser!.id!);
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),

          ],
        ),
        child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: settingsprovider.isDark()?AppColor.taskitemdark:AppColor.whitecolor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       margin: EdgeInsets.all(15),
                       color: AppColor.primarycolor,
                       width:5 ,
                       height:height*.1 ,
                     ),
                     Expanded(child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(widget.model.tittle,
                         style: them.textTheme.bodySmall?.copyWith(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: AppColor.primarycolor
                         ),),
                         Text(widget.model.description,
                           style: them.textTheme.bodySmall?.copyWith(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: settingsprovider.isDark()?AppColor.primarycolor:AppColor.blackcolor
                         ),)
                       ],
                     ) ),
                     InkWell(
                       onTap: (){
                         FirebaseUtils.updateTask(widget.model, authprovider.currentuser!.id!);

                       },
                       child: widget.model.isdone? Text('Done',style:
                         them.textTheme.bodyLarge!.copyWith(
                           color: Colors.green,
                           fontSize: 25
                         ),):Container(
                         margin: EdgeInsets.all(10),
                         padding: EdgeInsets.symmetric(horizontal: 8),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           color:  AppColor.primarycolor,

                         ),
                         child:IconButton(onPressed: (){}, icon: Icon(Icons.check,
                           size: 35,
                           color: AppColor.whitecolor,)) ,
                       ),
                     ),
                   ],
          ),
        ),
      ),
    );
  }
}
