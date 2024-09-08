import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/settings_provider.dart';

import '../../core/app_color.dart';
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

  @override
  Widget build(BuildContext context) {
    var settingsprovider=Provider.of<SettingsProvider>(context);
    List<String>language=[
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.arabic

    ];
    List<String>mode=[
      AppLocalizations.of(context)!.light_mode,
      AppLocalizations.of(context)!.dark_mode
    ];
    var mediaquary=MediaQuery.of(context);
    var them=Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Container(
        width: mediaquary.size.width,
        height: mediaquary.size.height *.22,
        color: AppColor.primarycolor,
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              top: 60
          ),
          child: Text(AppLocalizations.of(context)!.settings,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: settingsprovider.isDark()?AppColor.blackcolor:AppColor.whitecolor
            ),),
        ),
      ),
      SizedBox(height: mediaquary.size.height*.06,),
      Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Text(AppLocalizations.of(context)!.language,
        style:them.textTheme.bodySmall?.copyWith(
          color: settingsprovider.isDark()?AppColor.whitecolor:AppColor.blackcolor,
          fontWeight: FontWeight.bold,
          fontSize: 19
        ) ,),
      ),
        SizedBox(height: 15,),
          Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: CustomDropdown<String>(
        decoration: CustomDropdownDecoration(
          listItemDecoration: ListItemDecoration(
            selectedColor: settingsprovider.isDark()?AppColor.whitecolor:AppColor.primarycolor,

          ),
          closedBorderRadius: BorderRadius.circular(15),

          closedFillColor:AppColor.whitecolor,
          expandedFillColor: AppColor.whitecolor,
          closedSuffixIcon: Icon(
            Icons.keyboard_arrow_down_sharp,
            color:AppColor.primarycolor
          ),
          expandedSuffixIcon: Icon(
            Icons.keyboard_arrow_up_sharp,
            color: AppColor.primarycolor
          ),
        ),
      hintText: 'Select Your language',
      items: language,
        initialItem:settingsprovider.currentlanguge == 'en'
            ? language[0]
            : language[1],
        onChanged: (value) {
          if (value ==  AppLocalizations.of(context)!.english) {
            settingsprovider.changeLanguageCode('en');
          }
          if (value ==  AppLocalizations.of(context)!.arabic) {
            settingsprovider.changeLanguageCode('ar');
          }
          log('changing value to: $value');
        },
      ),
    ),
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Text(AppLocalizations.of(context)!.mode
            ,
            style:them.textTheme.bodySmall?.copyWith(
                color:settingsprovider.isDark()?AppColor.whitecolor: AppColor.blackcolor,
                fontWeight: FontWeight.bold,
                fontSize: 19
            ) ,),
        ),
        SizedBox(height: 15,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
          child: CustomDropdown<String>(
            decoration: CustomDropdownDecoration(
              listItemDecoration: ListItemDecoration(
                selectedColor:settingsprovider.isDark()?AppColor.whitecolor: AppColor.primarycolor,

              ),
              closedBorderRadius: BorderRadius.circular(15),

              closedFillColor:AppColor.whitecolor,
              expandedFillColor: AppColor.whitecolor,
              closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color:AppColor.primarycolor
              ),
              expandedSuffixIcon: Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: AppColor.primarycolor
              ),
            ),
            hintText: 'Select Your Mode',
            items: mode,
            initialItem: settingsprovider.currentthemmode == ThemeMode.dark
                ? mode[1]
                : mode[0],
            onChanged: (value) {
              if (value == AppLocalizations.of(context)!.dark_mode) {
                settingsprovider.changeThemMode(ThemeMode.dark);
              }
              if (value == AppLocalizations.of(context)!.light_mode ) {
                settingsprovider.changeThemMode(ThemeMode.light);
              }

              log('changing value to: $value');
            },
          ),
        ),


    ],

    );
  }
}
