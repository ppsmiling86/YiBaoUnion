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
import 'package:myapp/models/Response.dart';
import 'package:myapp/models/UserInfoBloc.dart';
import 'package:myapp/tools/numberTools.dart';
import 'package:myapp/views/checkin_view.dart';

class UserProfilePage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return UserProfilePageState();
	}
}

class UserProfilePageState extends State <UserProfilePage> {
	final bloc = UserInfoBloc();
	final _notLoginUser = UserInfoEntity("", 0, 0, "", "", "", 0);

	@override
  void dispose() {
    super.dispose();
	bloc.dispose();
  }

	@override
	Widget build(BuildContext context) {
		bool isLogin = AppData().loginUser().isLoggedIn;
		if (isLogin) {
			bloc.userInfo();
		}
		return Drawer(
			child: Stack(
				children: <Widget>[
					buildAlternativeBody(isLogin),
					buildBottomLogoutButtons(isLogin),
				],
			),
		);
	}

	Widget buildAlternativeBody(bool isLogin) {
		if (isLogin) {
			return buildStreamBuilderView();
		} else {
			return buildBody(_notLoginUser);
		}
	}

	StreamBuilder buildStreamBuilderView() {
		return StreamBuilder<UserInfoResponse>(
			stream: bloc.subject.stream,
			builder: (context, AsyncSnapshot<UserInfoResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					AppData().loginUser().userProfileEntity = snapshot.data.data;
					return buildBody(snapshot.data.data);
				} else if (snapshot.hasError) {
					print("hasError");
					return Container();
				} else {
					print("loading");
					return SizedBox(
						width: double.infinity,
						height: 100,
						child: Container(
							child: Center(child: CircularProgressIndicator()),
						),
					);
				}
			});
	}



	Widget buildBody(UserInfoEntity userInfoEntity) {
		bool isLogin = AppData().loginUser().isLoggedIn;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: ListView(
				children: <Widget>[
					buildUserAvatar(userInfoEntity),
					buildUserSummary(userInfoEntity),
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
					buildSingleRow("签到有礼", (){
						if(isLogin) {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => CheckInView()),
							);
						} else {
							gotoRegistrationPage();
						}
					}),
					Divider(),
					buildSingleRow("关于我们", (){
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => AboutUsView()),
						);
					}),
					Divider(),
					buildSingleRow("联系客服", (){
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => ContactCustomerServiceView()),
						);
					}),
					SizedBox(height: 500),
				],
			),
		);
	}

	Widget buildUserAvatar(UserInfoEntity userInfoEntity) {
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
					isLogin ? Text(userInfoEntity.uid) :
					OutlineButton(
						borderSide: BorderSide(
							color: Colors.grey,
							style: BorderStyle.solid,
							width: 2,
						),
						onPressed: (){
							gotoRegistrationPage();
						},
						child: Text("登录")
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

	Widget buildUserSummary(UserInfoEntity userInfoEntity) {
		return Container(
			height: 120,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("我的共创积分: ${NumberTools.DoubleToFixedString(userInfoEntity.balance, 2)}"),
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
					Text("我的总算力: ${userInfoEntity.today_rent_power} U"),
					SizedBox(height: 16),
					Expanded(child: Text("大约还可产生${NumberTools.DoubleToFixedString(userInfoEntity.today_score, 2)}共创积分")),
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

	Widget buildBottomLogoutButtons(bool isLogin) {
		var width = MediaQuery.of(context).size.width - 32;
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
					}, child: Text("退出登录", style: TextStyle(color: Colors.white),)
				),
			),
		) : Container();
	}

}