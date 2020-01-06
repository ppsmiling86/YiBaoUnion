import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:myapp/tools/imageTools.dart';
class WithdrawView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return WithdrawViewState();
	}
}

class WithdrawViewState extends State <WithdrawView> {
	final walletController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text("提现"),
			),
			body: buildBody(),
			bottomNavigationBar: buildBottomLogoutButtons(),
		);
	}

	Widget buildWallet() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			height: 100,
			width: width,
			child: Column(
				children: <Widget>[
					TextFormField(
						controller: walletController,
						decoration: InputDecoration(
							icon: Icon(Icons.account_balance_wallet),
							labelText: '共创钱包地址:',
							hintText: "请输入或长按粘贴地址"
						),
						onSaved: (String value) {
							AppData().withdrawRequest.walletAddress = value;
						},
						validator: (String value) {
							if (value.isEmpty) {
								return '请输入提币地址';
							}
							return null;
						},
					),
				],
			),
		);
	}

	Widget buildBody() {
		var width = MediaQuery.of(context).size.width - 32;
		return ListView(
			children: <Widget>[
			Image(
			width: width,
			fit: BoxFit.fill,
			image: AssetImage(ImageTools.placeholder1)
		),
			],
		);
	}

	Widget buildAmount() {
		return Container(
			color: Colors.red,
			height: 100,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					TextFormField(
						decoration: InputDecoration(
							icon: Icon(Icons.account_balance_wallet),
							labelText: '数量:',
							hintText: "最小提现积分数量为10"
						),
						onSaved: (String value) {
							AppData().withdrawRequest.walletAddress = value;
						},
						validator: (String value) {
							if (value.isEmpty) {
								return '请输入提现积分数量';
							}
							return null;
						},
					),

					Text("可提现积分: 1000"),
				],
			),
		);
	}

	Widget buildDescription() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			height: 100,
			width: width,
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			child: Expanded(child: Text("请务必输入正确的共创医保钱包地址，若因为个人失误导致资金丢失，平台概不负责。为了保证您的资金安全，我们会对提现申请进行人工审核，请耐心等待！")),
		);
	}

	Widget buildBottomLogoutButtons() {
		var width = MediaQuery.of(context).size.width - 32;
		return Align(
			alignment: Alignment.bottomCenter,
			child: Container(
				height: 100,
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				width: width,
				child: FlatButton(
					color: ColorTools.green1AAD19,
					onPressed: (){

					}, child: Text("提现",style: TextStyle(color: Colors.white))
				),
			),
		);
	}
}