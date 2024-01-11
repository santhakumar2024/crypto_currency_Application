// ignore_for_file: camel_case_types, prefer_const_constructors

import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apptheme.dart';
class updateprofile extends StatelessWidget {
   updateprofile({super.key});

  final TextEditingController email=TextEditingController();
  final TextEditingController name= TextEditingController();

   Future<void> savedata(String key,String value) async {
    SharedPreferences _prefs=await SharedPreferences.getInstance();
    await _prefs.setString(key, value);

   }

  void submitdetails() async{
   await savedata('name', name.text);
   await savedata('email', email.text);
   print('got');

  }


    Widget customtextfield(String title, TextEditingController controller){
      return Padding(
        padding: const EdgeInsets.all(15.0),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            hintText: title
            ),
            controller: controller,
            ),
          );
    }
  bool darkmode=AppTheme.isDarkModeEnabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE CREATION'),
      ),
      body: Column(
        children: [
           customtextfield('name',name),
             customtextfield('email',email),
             ElevatedButton(child:Text('submit details'),onPressed: (){
              submitdetails();
              },)
        ],
      ),
    );
  }
}