import 'package:flutter/material.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/views/home_view.dart';
import 'package:myapp/tools/localStorageTools.dart';
import 'package:myapp/views/UseBrowserOpen.dart';
import 'package:myapp/tools/userAgent.dart';
import 'package:myapp/models/AppData.dart';
//scp -r ./build/web/** root@47.108.62.79:/opt/front
//Ethan1102
//flutter run -d chrome
//
//http://www.longmonrent.com:8888/dc5cd39c/
//username: fsb5xghy
//password: fa70dbd8

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final userAgent = UserAgent();
    LocalStorageTools.saveInitRedirectUrl();
    LocalStorageTools.saveUpperInviteCode();
    print("upper invite code is :${LocalStorageTools.getUpperInviteCode()}");
    final newTextTheme = Theme.of(context).textTheme.apply(
      bodyColor: Colors.black54,
      displayColor: Colors.black54,
    );
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
        toggleableActiveColor:ColorTools.whiteFFFFFF,
        buttonColor: ColorTools.green1AAD19,
        errorColor: ColorTools.redE64340,
        indicatorColor:ColorTools.greyA1A6B3,
        textTheme: newTextTheme,
      ),
      home: userAgent.isWeChatOpen() ? UseBrowserOpenView() : HomeView(),
    );
  }
}
