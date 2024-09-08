import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/task.dart';

class FirebaseUtils{
  static CollectionReference<Task>  getTaskCollection(String uId){
   return
    getUserCollection().doc(uId).collection(Task.collectionName).
    withConverter<Task>(
        fromFirestore:((snapshot,options)=> Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,options)=> task.toJson()
    );
  }
static Future<void> addTaskToFireStore(Task task,String uId){
   var taskCollectionRef=  getTaskCollection(uId);    //collection
   DocumentReference<Task> taskDocRef = taskCollectionRef.doc();   //doc
   task.id = taskDocRef.id;
   return taskDocRef.set(task);


}
static Future<void> deleteTaskFromFireStore(Task task,String uId){
    return getTaskCollection(uId).doc(task.id).delete();
}
static Future<void> updateTask(Task task,String uId){
    var collectionref=getTaskCollection(uId);
    var docref=collectionref.doc(task.id);
    return docref.update({
      "isdone":true
    });
}
  static CollectionReference<MyUser>  getUserCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore:((snapshot,options)=> MyUser.fromFireStore(snapshot.data()!)),
        toFirestore: (myUser,options)=> myUser.toJson()
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUserCollection().doc(myUser.id).set(myUser);


  }


  static Future<MyUser?> readFromFireStore(String uId)async{


   var quarysnapshot=  await getUserCollection().doc(uId).get();
   return quarysnapshot.data();
  }

}