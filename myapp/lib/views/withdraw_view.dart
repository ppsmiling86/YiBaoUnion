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
		return SizedBox(
			width: double.infinity,
		  height: 120,
		  child: Container(
		  	padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
		  ),
		);
	}

	Widget buildBody() {
		return ListView(
			children: <Widget>[
				buildWallet(),
				buildAmount(),
				buildDescription(),
			],
		);
	}

	Widget buildAmount() {
		return SizedBox(
			width: double.infinity,
		  height: 120,
		  child: Container(
		  	padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
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
		  ),
		);
	}

	Widget buildDescription() {
		return SizedBox(
			width: double.infinity,
			height: 100,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: Row(
					children: <Widget>[
						Expanded(child: Text("请务必输入正确的共创医保钱包地址，若因为个人失误导致资金丢失，平台概不负责。为了保证您的资金安全，我们会对提现申请进行人工审核，请耐心等待！")),
					],
				),
			),
		);
	}

	Widget buildBottomLogoutButtons() {
		return SizedBox(
			width: double.infinity,
		  height: 250,
		  child: Container(
			  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			  child: Column(
				  children: <Widget>[
				  	Divider(),
				  	SizedBox(height: 16),
				  	Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Text("短信验证码"),
						],
					),
					  SizedBox(height: 16),
					  Row(
						  mainAxisAlignment: MainAxisAlignment.spaceBetween,
						  children: <Widget>[
							  Expanded(
							    child: TextFormField(
								  decoration: InputDecoration(
									  icon: Icon(Icons.account_balance_wallet),
									  hintText: "6位数字验证码"
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
							  ),
							  SizedBox(
								  width: 100,
							    height: 40,
							    child: Container(
									padding: EdgeInsets.only(left: 16,right: 16),
							      child: FlatButton(
								  color: ColorTools.blue5677FC,
								  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
								  onPressed: (){

								  },
								  child: Text("发送",style: TextStyle(color: Colors.white),)
							      ),
							    ),
							  ),
						  ],
					  ),
					  SizedBox(height: 16),
					  Row(
						  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						  children: <Widget>[
							  Expanded(
								  flex: 1,
							    child: Container(
								  height: 40,
								  padding: EdgeInsets.only(right: 8),
								  child: OutlineButton(
									  borderSide: BorderSide(
										  color: ColorTools.green1AAD19,
										  style: BorderStyle.solid,
										  width: 2,
									  ),
									  child: Text("取消",style: TextStyle(color: ColorTools.green1AAD19)),
									  onPressed: (){

									  }),
							    ),
							  ),
							  Expanded(
								  flex: 1,
							    child: Container(
								  height: 40,
								  padding: EdgeInsets.only(left: 8),
								  child: FlatButton(
									  color: ColorTools.green1AAD19,
									  onPressed: (){}, child: Text("确认",style: TextStyle(color: Colors.white),))
							    ),
							  ),
						  ],
					  ),
				  ],
			  ),
		  ),
		);
	}
}