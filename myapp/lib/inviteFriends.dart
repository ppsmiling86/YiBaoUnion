import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'imageTools.dart';

class InviteFriendsView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return InviteFriendsViewState();
  }
}

class InviteFriendsViewState extends State<InviteFriendsView> {
	@override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
				Navigator.of(context).pop();
			}),
			title: Text("邀请好友"),
			centerTitle: true,
		),
		body: ListView(
			children: <Widget>[
				Text("邀请好友可获得20%分成"),
				SizedBox(height: 50),
				SizedBox(
					width: 100,
					height: 100,
					child: Image(
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder_qrcode),width: 100,height: 100),
				)
			],
		),
	);
  }
}