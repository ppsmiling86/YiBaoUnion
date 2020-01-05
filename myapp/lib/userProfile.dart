import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/AppData.dart';
import 'orderlist_view.dart';
import 'registrationPage.dart';
import 'withdraw_view.dart';
import 'inviteFriends.dart';

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
			child: Stack(
				children: <Widget>[
					buildBody(),
					buildBottomLogoutButtons(),
				],
			),
		);
	}

	Widget buildBody() {
		bool isLogin = AppData().loginUser.isLoggedIn;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: ListView(
				children: <Widget>[
					buildUserAvatar(),
					buildUserSummary(),
					Divider(),
					buildSingleRow("租赁订单", (){
						if (isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => OrderListView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
					Divider(),
					buildSingleRow("提现记录", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => WithdrawView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
					Divider(),
					buildSingleRow("邀请好友", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => InviteFriendsView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
				],
			),
		);
	}

	Widget buildUserAvatar() {
		bool isLogin = AppData().loginUser.isLoggedIn;
		return Container(
			height: 50,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					CircleAvatar(
						child: Icon(Icons.person),
					),
					OutlineButton(
						borderSide: BorderSide(
							color: Colors.grey,
							style: BorderStyle.solid,
							width: 2,
						),
						onPressed: (){
							if (!isLogin) {
								gotoRegistrationPage();
							}
						},
						child: Text(isLogin ? AppData().loginUser.loginPhoneNumber : "未登录")),

				],
			),
		);
	}

	void gotoRegistrationPage() {
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) => RegistrationPage()),
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
							Text("我的总算力: ${AppData().loginUser.totalCalculatorPower}U"),
							OutlineButton(
								child: Text("提现"),
								onPressed: (){

								},
							),
						],
					),
					Text("每天可以挖矿生产约${AppData().loginUser.creditsCanGenerateToday}共创积分"),
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
		var width = MediaQuery.of(context).size.width - 32;
		bool isLogin = AppData().loginUser.isLoggedIn;
		return isLogin ?  Align(
			alignment: Alignment.bottomCenter,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				width: width,
				child: FlatButton(
					color: Colors.red,
					onPressed: (){
						setState(() {
							AppData().loginUser.logout();
						});
					}, child: Text("退出")
				),
			),
		) : Container();
	}

}