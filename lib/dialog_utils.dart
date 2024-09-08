

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/app_color.dart';

class   DialogUtils{

  static void showLoading({required BuildContext context,required String message}){


    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context)=>AlertDialog(
      title: Row(
        children: [
         CircularProgressIndicator(color: Colors.blue,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(message),
         )
        ],
      ),
        )
    );

  }
  static void hideLoading( BuildContext context){

    Navigator.pop(context);
  }
  static void showMessage({required BuildContext context,required String content,String? textButton}){
    showDialog(context: context,
        builder:(context)=>
            AlertDialog(
              title: Text('Alert'),
              content: Text(content,style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColor.blackcolor
              ),) ,
              actions: [
                TextButton(onPressed: (){Navigator.pop(context);},
                    child:Text(textButton ?? "",style:
                      TextStyle(
                        color: AppColor.primarycolor
                      ),) )
              ],
            )
    );
  }
}