import 'package:flutter/material.dart';
import 'package:myapp/views/home_view.dart';
import 'dart:html';
import 'models/AppData.dart';
//flutter run -d chrome

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    saveInviteCode();
    return MaterialApp(
      title: '共创医保',
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

  void saveInviteCode() {
    var url = window.location.href;
    print("url is $url");
    Uri uri = Uri.dataFromString("url");
    var inviteCode = uri.queryParameters["inviteCode"];
    Storage localStorage = window.localStorage;
    localStorage[kInviteCode] = inviteCode;
  }

}
