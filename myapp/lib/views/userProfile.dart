import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/colorTools.dart';
import 'orderlist_view.dart';
import 'registrationPage.dart';
import 'withdraw_view.dart';
import 'inviteFriends.dart';
import 'withdraw_history_view.dart';
import 'my_friends_view.dart';
import 'package:ant_icons/ant_icons.dart';
import 'about_us_view.dart';
import 'contact_customer_service.dart';
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
		bool isLogin = AppData().loginUser().isLoggedIn;
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
								MaterialPageRoute(builder: (context) => WithdrawHistoryView()),
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
					Divider(),
					buildSingleRow("我的团队", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => MyFriendsView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
					Divider(),
					buildSingleRow("关于我们", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => AboutUsView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
					Divider(),
					buildSingleRow("联系客服", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => ContactCustomerServiceView()),
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
		bool isLogin = AppData().loginUser().isLoggedIn;
		return Container(
			height: 50,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					CircleAvatar(
						child: Icon(Icons.person),
					),
					SizedBox(width: 16),
					isLogin ? Text(AppData().loginUser().mobile) :
					OutlineButton(
						borderSide: BorderSide(
							color: Colors.grey,
							style: BorderStyle.solid,
							width: 2,
						),
						onPressed: (){
							gotoRegistrationPage();
						},
						child: Text("未登录")
					),
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
			height: 110,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("我的共创积分: 0"),
							OutlineButton(
								child: Text("提现"),
								onPressed: (){
									if(AppData().loginUser().isLoggedIn) {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => WithdrawView()),
										);
									} else {
										gotoRegistrationPage();
									}
								},
							),
						],
					),
					Text("我的总算力: xxxxx U"),
					SizedBox(height: 16),
					Text("每天可以挖矿生产约 xxxx 共创积分"),
				],
			),
		);
	}

	Widget buildSingleRow(String title,Function onTap) {
		return InkWell(
			onTap: onTap,
			child: Container(
				height: 40,
				padding: EdgeInsets.symmetric(horizontal: 16),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						Text(title),
						Icon(AntIcons.right_outline,color: ColorTools.greyA1A6B3,size: 12,),
					],
				),
			),
		);
	}

	Widget buildBottomLogoutButtons() {
		var width = MediaQuery.of(context).size.width - 32;
		bool isLogin = AppData().loginUser().isLoggedIn;
		return isLogin ?  Align(
			alignment: Alignment.bottomCenter,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				width: width,
				child: FlatButton(
					color: Colors.red,
					onPressed: (){
						setState(() {
							AppData().loginUser().logout();
						});
					}, child: Text("退出")
				),
			),
		) : Container();
	}

}