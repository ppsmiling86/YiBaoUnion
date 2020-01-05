import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'imageTools.dart';
import 'colorTools.dart';
import 'waiverPage.dart';
import 'userProfile.dart';
import 'AppData.dart';
import 'registrationPage.dart';

class CheckoutPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return CheckoutPageState();
	}
}

class CheckoutPageState extends State <CheckoutPage> {
	@override
  void initState() {
    if(AppData().loginUser == null) {
		AppData().loginUser = User(false, "","", 0, 0, 0, []);
	}
    super.initState();
  }

	@override
	Widget build(BuildContext context) {
		var width = MediaQuery.of(context).size.width - 32;
		return Scaffold(
			appBar: AppBar(
				leading:
				Builder(builder: (context) =>
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
			body: ListView(
				children: <Widget>[
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder1)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder2)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder3)
					),
				],
			),
			bottomNavigationBar: buildProductDetail(),
		);
	}

	Widget buildBody() {
		var width = MediaQuery.of(context).size.width - 32;
		var height = MediaQuery.of(context).size.height - 300;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			width: width,
			height: height,
			child: ListView(
				children: <Widget>[
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder1)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder2)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder3)
					),
				],
			),
		);
	}

	Widget buildProductDetail() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			width: width,
			height: 300,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Container(
						height: 40,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text("算力单价"),
								Text("100 / U"),
							],
						),
					),
					Container(
						height: 40,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text("数量 (U)"),
								Container(
									width: 100,
									child: Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
											GestureDetector(
												child: Text("   -   ",style: TextStyle(color: Colors.grey)),
												onTap: (){

												},
											),
											Container(
												width: 40,
												child: TextFormField(
													textAlign: TextAlign.center,
													onSaved: (String value) {

													},
													validator: (String value) {
														return value.contains('@') ? 'Do not use the @ char.' : null;
													},
												),
											),
											GestureDetector(
												child: Text("   +   ",style: TextStyle(color: Colors.grey)),
												onTap: (){

												},
											),
										],
									),
								)
							],
						),
					),
					SizedBox(height: 10),
					Container(
						height: 40,
						child: Row(
							children: <Widget>[
								Expanded(child: Text("租赁周期为24小时,每U算力24小时大约可产生1个共创积分,24小时后，积分将自动发放到账户",style: TextStyle(color: Colors.red),)),
							],
						),
					),
					SizedBox(height: 30),
					Container(
						height: 40,
						child: Row(
							children: <Widget>[
								Text("合计: ¥ 100000")
							],
						),
					),
					buildBottomButtons(),
				],
			),
		);
	}

	Widget buildBottomButtons() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			height: 60,
			width: width,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Expanded(
						child: OutlineButton(
							borderSide: BorderSide(
								color: Colors.grey,
								style: BorderStyle.solid,
								width: 2,
							),
							textColor: Colors.grey,
							child: Text("取消"),
							onPressed: (){
								Navigator.of(context).pop();
							},
						),
					),
					SizedBox(width: 20),
					Expanded(
						child: Container(
							child: FlatButton(
								color: ColorTools.green1AAD19,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
								onPressed: (){
									if (AppData().loginUser.isLoggedIn) {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => WaiverPage()),
										);
									} else {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => RegistrationPage()),
										);
									}
								},
								child: Text("确认租赁",style: TextStyle(color: Colors.white),)
							)
						),
					),
				],
			),
		);
	}
}