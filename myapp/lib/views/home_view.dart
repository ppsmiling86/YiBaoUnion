import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_views/center_view.dart';
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
class HomeView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return HomeViewState();
	}
}

class HomeViewState extends State<HomeView> {
	@override
	void initState() {
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithBuilder(context, "首页"),
			drawer: UserProfilePage(),
			body: CenterView(),
			bottomNavigationBar: buildBottomButtons(),
		);
	}

	Widget buildBottomButtons() {
		return Container(
			height: 80,
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Expanded(
						child: SizedBox(
							height: 60,
							child: FlatButton(
								color: ColorTools.green1AAD19,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
								onPressed: (){
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
								child: Text("立即租赁算力",style: TextStyle(color: Colors.white))
							),
						),
					),
				],
			),
		);
	}
}