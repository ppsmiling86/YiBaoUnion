import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/stringTools.dart';
import 'manage_address_view.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/WithdrawAddressListBloc.dart';
import 'package:myapp/models/Response.dart';

class WithdrawView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return WithdrawViewState();
	}
}

class WithdrawViewState extends State <WithdrawView> {
	final _mainFormKey = GlobalKey<FormState>();
	final _dialogFormKey = GlobalKey<FormState>();
	final walletController = TextEditingController();
	final amountController = TextEditingController();
	final verifyController = TextEditingController();
	final listBloc = WithdrawAddressListBloc();

	@override
  void dispose() {
    walletController.dispose();
    amountController.dispose();
    verifyController.dispose();
    listBloc.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitleActions(context, "提现", [
				GestureDetector(
					onTap: (){
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => ManageAddressView()),
						);
					},
					child: SizedBox(
						width: 80,
						child: Container(
							child: Center(child: Text("管理地址")),
						),
					),
				),
			]),
			body: buildBody(),
			bottomNavigationBar: CommonWidgetTools.buildBottomButton("提现", (){
				if (_mainFormKey.currentState.validate()) {
					showModalBottomSheet(context: context, builder: (BuildContext context) => buildBottomLogoutButtons());
				}
			}),
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
						Row(
							mainAxisAlignment: MainAxisAlignment.start,
							children: <Widget>[
								Expanded(
								  child: TextFormField(
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
								),
								SizedBox(
									width: 80,
									height: 30,
									child: Container(child: Center(child: OutlineButton(onPressed: (){
										listBloc.getWithdrawAddress();
										showDialog(
											barrierDismissible: false,
											context: context,
											builder: (BuildContext context){
												return buildWithdrawListStreamBuilderView();
											}
										);
									},child: Text("选择"))))
								),
							],
						),
					],
				),
			),
		);
	}

	StreamBuilder buildWithdrawListStreamBuilderView() {
		return StreamBuilder<WithdrawAddressListResponse>(
			stream: listBloc.subject.stream,
			builder: (context, AsyncSnapshot<WithdrawAddressListResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					return AlertDialog(
						title: Text("请选择提现地址"),
						content: Center(
							child: SizedBox(
								width: 300,
								height: 300,
								child: Container(
									padding: EdgeInsets.symmetric(horizontal: 16),
									child: ListView.separated(
										itemBuilder: (contest,index) => buildAddressItem(snapshot.data.data[index]),
										separatorBuilder: (context, index) => Divider(),
										itemCount: snapshot.data.data.length,
									),
								),
							),
						),
					);
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

	Widget buildAddressItem(WithdrawAddressEntity withdrawAddressEntity) {
		return InkWell(
			onTap: (){
				Navigator.pop(context);
				setState(() {
					walletController.text = withdrawAddressEntity.address;
				});
			},
		  child: Container(
		  	child: Row(
		  		mainAxisAlignment: MainAxisAlignment.start,
		  		children: <Widget>[
		  			Expanded(
		  				flex: 1,
		  				child: buildListColumn("备注", withdrawAddressEntity.tag)),
		  			Expanded(
		  				flex: 1,
		  				child: buildListColumn("地址", withdrawAddressEntity.address)),
		  		],
		  	),
		  ),
		);
	}

	Widget buildListColumn(String title, String value) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Text(title),
				Text(value,style: TextStyle(color: Colors.grey)),
			],
		);
	}

	Widget buildBody() {
		return Form(
			key: _mainFormKey,
		  child: ListView(
		  	children: <Widget>[
		  		buildWallet(),
		  		buildAmount(),
		  		buildDescription(),
		  	],
		  ),
		);
	}

	Widget buildAmount() {
		return SizedBox(
			width: double.infinity,
			height: 150,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Row(
							children: <Widget>[
								Expanded(
								  child: TextFormField(
									  controller: amountController,
								  	decoration: InputDecoration(
								  		icon: Icon(Icons.monetization_on),
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
								),
								SizedBox(
									width: 80,
									height: 30,
									child: Container(child: Center(child: OutlineButton(onPressed: (){
										setState(() {
											amountController.text = "1000";
										});
									},child: Text("全部"))))
								),
							],
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
										controller: verifyController,
										decoration: InputDecoration(
											icon: Icon(Icons.account_balance_wallet),
											hintText: "6位数字验证码"
										),
										onSaved: (String value) {
											AppData().withdrawRequest.verifyCode = value;
										},
										validator: (String value) {
											if (!StringTools.ValidateSmsCode(value)) {
												return '请输入6位数字验证码';
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
												CommonWidgetTools.showToastView(context, "复制成功");
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
												Navigator.pop(context);
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
											onPressed: (){
												Navigator.pop(context);
											}, child: Text("确认",style: TextStyle(color: Colors.white),))
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