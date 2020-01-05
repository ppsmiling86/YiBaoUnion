import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/AppData.dart';
import 'orderlist_view.dart';
class UserProfilePage extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return UserProfilePageState();
  }
}

class UserProfilePageState extends State <UserProfilePage> {
	@override
  Widget build(BuildContext context) {
		return Drawer(
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16),
				child: ListView(
					children: <Widget>[
						buildUserAvatar(),
						buildUserSummary(),
						Divider(),
						buildSingleRow("租赁订单", (){
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => OrderListView()),
							);
						}),
						Divider(),
						buildSingleRow("修改密码", (){

						}),
						Divider(),
						buildSingleRow("邀请好友", (){

						}),
					],
				),
			),
		);
  }

  Widget buildUserAvatar() {
		return Container(
			height: 50,
			padding: EdgeInsets.symmetric(horizontal: 16),
		  child: Row(
		  	mainAxisAlignment: MainAxisAlignment.spaceBetween,
		  	children: <Widget>[
		  		CircleAvatar(
		  			child: Text("CT"),
		  		),
		  		Text(AppData().loginUser.loginPhoneNumber),
		  	],
		  ),
		);
  }

  Widget buildUserSummary() {
		return Container(
			height: 100,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("我的总算力: 1000U"),
							OutlineButton(
								child: Text("提现"),
								onPressed: (){

								},
							),
						],
					),
					Text("每天可以挖矿生产约1000共创积分"),
				],
			),
		);
  }

  Widget buildSingleRow(String title,Function onTap) {
		return GestureDetector(
			onTap: onTap,
		  child: Container(
		  	height: 40,
		    padding: EdgeInsets.symmetric(horizontal: 16),
		    child: Row(
		    	mainAxisAlignment: MainAxisAlignment.spaceBetween,
		    	children: <Widget>[
		    		Text(title),
		    		Icon(Icons.arrow_right),
		    	],
		    ),
		  ),
		);
  }

  Widget buildBottomLogoutButtons() {
		return Container(
			child: FlatButton(
				color: Colors.red,
				onPressed: (){
				AppData().loginUser.logout();
			}, child: Text("退出")
			),
		);
  }

}