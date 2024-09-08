import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{

  List<Task>tasklist=[];

DateTime selectDate = DateTime.now();

  void getAllDataFromFireStore(String uId)async{

    QuerySnapshot<Task> querysnapshot = await FirebaseUtils.getTaskCollection(uId).get();
    tasklist= querysnapshot.docs.map((doc){
      return doc.data();
    }).toList();

   tasklist= tasklist.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month
          && selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();
   tasklist.sort((Task task1,Task task2){
return task1.dateTime.compareTo(task2.dateTime);
    });
  notifyListeners();
  }

  void changeSelectedDate(DateTime newselecteddate,String uId){

    selectDate=newselecteddate;
    getAllDataFromFireStore(uId);
    notifyListeners();

  }

}
