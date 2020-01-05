import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/center_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'userProfile.dart';
import 'registrationPage.dart';
import 'AppData.dart';
import 'checkoutPage.dart';
import 'colorTools.dart';

class HomeView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return HomeViewState();
	}
}

class HomeViewState extends State<HomeView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: Builder(builder: (context) =>
					IconButton(
						icon: CircleAvatar(
							child: Icon(Icons.person),
						),
						onPressed: (){
							Scaffold.of(context).openDrawer();
						})
				),
			),
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
						flex: 1,
					  child: Column(
						  mainAxisAlignment: MainAxisAlignment.spaceBetween,
					  	crossAxisAlignment: CrossAxisAlignment.start,
					  	children: <Widget>[
					  		Text("今日认租: 30%"),
					  		LinearPercentIndicator(
					  			width: 100.0,
					  			lineHeight: 8.0,
					  			percent: 0.3,
					  			progressColor: Colors.blue,
					  		),
					  	],
					  ),
					),
					Expanded(
						flex: 2,
						child: SizedBox(
							height: 60,
						  child: FlatButton(
						  	color: ColorTools.green1AAD19,
						  	shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
						  	onPressed: (){
						  		if (AppData().loginUser.isLoggedIn) {
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