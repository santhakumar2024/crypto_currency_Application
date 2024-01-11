// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:crypto_app/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'apptheme.dart';
import 'coin_details.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}







class _HomescreenState extends State<Homescreen> {
  
String url="https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en";
String name="";
String email="";
bool isdarkmode=AppTheme.isDarkModeEnabled;
static GlobalKey <ScaffoldState> _globalkey=GlobalKey<ScaffoldState>();

@override
void initState()
{
  super.initState();
  getdetails();
  get_coindetails();
}
void getdetails()
async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
 
 setState(() {
  name=prefs.getString('name') ?? "";
  email=prefs.getString('email') ?? "";
  //print('done');
  });
}
Future<List<coindetail>> get_coindetails()async{
  Uri uri=Uri.parse(url);
 final  response=await http.get(uri);
 if(response.statusCode==200||response.statusCode==201){
  List coindata=jsonDecode(response.body);
  List<coindetail>data=coindata.map((e) => coindetail.fromJson(e)).toList();

  return data;
  //print("the response in the if case :--  ${response.body}\n");
 }
 else{
  return <coindetail>[];
 // print("the error occured in the process  :--  ${response.statusCode}\n");
 }
// print('Response status: ${response.statusCode}\n');
// print('Response body: ${response.body}\n');
// print(response);
 }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalkey,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          _globalkey.currentState!.openDrawer();
          },icon: Icon(Icons.menu,
        color:Colors.black),),
        backgroundColor: Colors.white,
        elevation:0,
        title: Text('CRYPTO CURRENCY APP',
        style: TextStyle(color: Colors.black),
        
        ),       
      ),
        drawer:Drawer(
          //backgroundColor:isdarkmode?Color.fromARGB(137, 54, 53, 53):Colors.white,
          backgroundColor:Colors.white,
        child:Column(
          children: [
            UserAccountsDrawerHeader(//color: isdarkmode?Color.fromARGB(137, 54, 53, 53):Color.fromARGB(255, 221, 189, 189),
              accountName: Text(name,
              style:TextStyle(color:isdarkmode? Colors.white:Colors.black) ,), 
              accountEmail: Text(email
              ,style:TextStyle(color: isdarkmode? Colors.white:Colors.black) ,),
              currentAccountPicture: Icon(
                color:isdarkmode? Colors.white:Colors.black,
                Icons.account_circle,
              size: 70, 
              ),
              
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> updateprofile(),
                  ),
                  );
                },
                leading: Icon(Icons.account_box),
                title:Text('UPDATE PROFILE'),
                
              ),
              ListTile(
                onTap: (){
                  setState(() {
                    isdarkmode=!isdarkmode;
                  });
                  
                },
                leading: Icon(isdarkmode?Icons.light_mode:Icons.dark_mode),
                title:Text(isdarkmode? 'light mode':'Dark Mode'),
                
              )
          ],
        )
      ),
      body: SizedBox(
        width:double.infinity,
        child: Column(
        children: [
          Padding(padding:EdgeInsets.symmetric(
            vertical: 20,horizontal: 15
          ),
          child:TextField(
            
            decoration:InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              hintText: "search",
            )
          ),
          
          ),
          Expanded(
            child: FutureBuilder(
              future: get_coindetails(),
              builder: (BuildContext context, AsyncSnapshot<List<coindetail>> snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
              itemCount:snapshot.data?.length ,
              itemBuilder: (context, index) {
              
              return coinDetails(snapshot.data![index]);
            },);
                }
                else{
                  return Center(
                    child:Text("there is nothing to show!!")
                    );
                }
              },
            ),
          )
        ],),
      ),
      //Expanded(child: Container(color: isdarkmode?Color.fromARGB(0, 61, 48, 55):Color.fromARGB(0, 250, 248, 248),))
    );
  }

Widget coinDetails(coindetail apifile){


return Padding(
  padding: const EdgeInsets.all(8.0),
  child:   ListTile(
  leading:Image.network(apifile.image),
    title:Text("${apifile.name}\n${apifile.symbol}  ${ apifile.high24h}"),
    
    trailing:RichText(
  
      textAlign: TextAlign.right,
  
      text:TextSpan(
         text:"${apifile.currentprice}\n",
  
      children: [
  
        TextSpan(
  
          text: "${apifile.pricechangepercentage24h}%",
  
          style:TextStyle(
  
          color:Colors.red),
  
          
  
        )
  
      ]),
  
      ),
    
  ),
  );
}
  
}