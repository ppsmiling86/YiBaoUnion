import 'package:flutter/material.dart';
import 'package:myapp/views/home_view.dart';
import 'package:myapp/tools/localStorageTools.dart';

//scp -r ./**  root@34.92.152.68:/opt/front
//flutter run -d chrome

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalStorageTools.saveUpperInviteCode();
    print("upper invite code is :${LocalStorageTools.getUpperInviteCode()}");
    return MaterialApp(
      title: '龙门算力租赁',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }



}
