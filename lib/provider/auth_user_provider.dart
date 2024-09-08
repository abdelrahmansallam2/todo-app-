import 'package:flutter/foundation.dart';
import 'package:todo_app/model/my_user.dart';

class AuthUserProvider extends ChangeNotifier{

  MyUser? currentuser;

  void updateUser(MyUser newuser){

    currentuser=newuser;
    notifyListeners();
  }

}