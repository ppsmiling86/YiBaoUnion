import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:myapp/models/MyNotification.dart';
import 'package:myapp/models/Response.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'userProfile.dart';
import 'registrationPage.dart';
import 'package:myapp/models/AppData.dart';
import 'checkoutPage.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/models/UserBloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/tools/userAgent.dart';
import 'package:myapp/tools/localStorageTools.dart';
import 'orderlist_view.dart';
import 'dart:async';


class HomeView extends StatefulWidget {
	final bool isInWechat;

  	const HomeView({Key key, this.isInWechat = false}) : super(key: key);


	@override
	State<StatefulWidget> createState() {
		return HomeViewState();
	}


}

class HomeViewState extends State<HomeView> {
	Timer _timer;

	@override
  void initState() {
    super.initState();
	_timer =  Timer(const Duration(milliseconds: 400), () {
		showOrderList();
	});
  }


  @override
  void dispose() {
	_timer.cancel();
    super.dispose();
  }


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: widget.isInWechat ? CommonWidgetTools.appBarInWechatWithBuilder(context, "首页") : CommonWidgetTools.appBarWithBuilder(context, "首页"),
			drawer: UserProfilePage(),
			body: CenterView(),
			bottomNavigationBar: buildBottomButtons(),
		);
	}

	Widget buildBottomButtons() {
		return Container(
			height: 60,
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
			child: Column(
				children: <Widget>[
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Expanded(
								child: SizedBox(
									height: 40,
									child: FlatButton(
										shape: StadiumBorder(),
										color: Theme.of(context).buttonColor,
										onPressed: (){
											if (widget.isInWechat) {
												MyNotification(true).dispatch(context);
												return;
											}
											if (AppData().loginUser().isLoggedIn) {
												Navigator.push(
													context,
													MaterialPageRoute(builder: (context) => CheckoutPage()),
												);
											} else {
												Navigator.push(
													context,
													MaterialPageRoute(builder: (context) => RegistrationPage()),
												);
											}
										},
										child: Text("立即租赁算力",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))
									),
								),
							),
						],
					),
				],
			),
		);
	}


	void showOrderList() {
		if (LocalStorageTools.isRediretToOrderList()) {
			LocalStorageTools.clearRedirectUrl();
			if (AppData().loginUser().isLoggedIn) {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => OrderListView()),
				);
			}
		}
	}
}