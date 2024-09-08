import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/page_routes_name.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/settings_provider.dart';
import '../../core/app_color.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {

  TextEditingController emailcontroler=TextEditingController();
  TextEditingController passwordcontroler=TextEditingController();
  TextEditingController personcontroler=TextEditingController();
  bool isobsecured=false;
  var Formkey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediquery=MediaQuery.of(context);
    var settingsprovider=Provider.of<SettingsProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/background.png',
        ),fit: BoxFit.cover),
        color: settingsprovider.isDark()?AppColor.scaffoldbackgrounddark:AppColor.scaffoldbackground,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme ,
          title:Text(AppLocalizations.of(context)!.create_acc,textAlign: TextAlign.center,
            style:
            Theme.of(context).textTheme.bodySmall,) ,
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(top: mediquery.size.height*.1,left: 20,right: 20),
            child: Form(
              key: Formkey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  SizedBox(height: mediquery.size.height*.16,),
                  TextFormField(
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return'Please Enter Your Name';
                      }
                      return null;
                    },
                    controller:personcontroler,
                    cursorColor: AppColor.primarycolor,
                    cursorHeight: 25,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 12
                      ),
                      hintText: 'Enter Your Name',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                      label: Text(AppLocalizations.of(context)!.full_name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: settingsprovider.isDark()?AppColor.whitecolor:Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.primarycolor,
                            width: 2
                        ),
                      ),
                      suffixIcon: Icon(Icons.person),
                    ),

                  ),

                  TextFormField(
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return'Please Enter Your E-Mail Adress ';
                      }
                      return null;
                    },
                    controller:emailcontroler ,
                    cursorColor: AppColor.primarycolor,
                    cursorHeight: 25,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: settingsprovider.isDark()?AppColor.whitecolor:Colors.black,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 12
                      ),
                      hintText: 'Enter Your E-Mail Adress',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                      label: Text(AppLocalizations.of(context)!.e_mail,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: settingsprovider.isDark()?AppColor.whitecolor:Colors.black,

                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.primarycolor,
                            width: 2
                        ),
                      ),
                      suffixIcon: Icon(Icons.email),
                    ),

                  ),

                  TextFormField(
                    obscureText: isobsecured,
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return'Please Enter Your password';
                      }
                      return null;
                    },
                    controller:passwordcontroler ,
                    cursorColor: AppColor.primarycolor,
                    cursorHeight: 25,
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: settingsprovider.isDark()?AppColor.whitecolor:Colors.black,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: 12
                      ),
                      hintText: 'Enter Your password',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                      ),
                      label: Text(AppLocalizations.of(context)!.password,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: settingsprovider.isDark()?AppColor.whitecolor:Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColor.primarycolor,
                            width: 2
                        ),
                      ),
                      suffixIcon: InkWell(
                          onTap: (){

                            setState(() {
                              isobsecured=!isobsecured;
                            });

                          },
                          child:  isobsecured ? Icon(Icons.visibility): Icon(Icons.visibility_off)),
                    ),

                  ),
                  SizedBox(height: 20,),


                  FilledButton(
                      style:
                      FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 12),
                          backgroundColor: AppColor.primarycolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                      onPressed: (){
                        register();
                      },
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.create_acc,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),),

                          Icon(Icons.arrow_forward_outlined),
                        ],
                      )),

                ],
              ),
            ),
          ),
        ),

      ),

    );

  }
  void register()async{
    if(Formkey.currentState!.validate()==true){
      DialogUtils.showLoading(context: context, message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroler.text,
          password: passwordcontroler.text,
        );
        MyUser myUser=MyUser(id:credential.user?.uid??'',
            name:personcontroler.text,
            email: emailcontroler.text);
       var authprovider=Provider.of<AuthUserProvider>(context,listen: false);
       authprovider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
      DialogUtils.hideLoading(context);
      DialogUtils.showMessage(context: context, content:'Register Successfully',textButton: 'OK');
      Navigator.pushNamed(context, PageRoutesName.login);
      }  catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context, content:e.toString(),
            textButton: 'Try Again');

      }
    }
  }
}
