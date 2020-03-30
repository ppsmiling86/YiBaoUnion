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
import 'package:myapp/models/ApiRepository.dart';
import 'withdraw_history_view.dart';
import 'package:myapp/models/WithdrawAvailableBloc.dart';

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
	final withAvailableBloc = WithdrawAvailableBloc();
	SMSEntity smsEntity;
	DateTime lastSendSmsTime;
	final _apiRepository = ApiRepository();



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
		withAvailableBloc.withdrawAvailable();
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
							child: Center(child: Text("管理地址",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
						),
					),
				),
			]),
			body: buildBodyBuilderView(),
			bottomNavigationBar: CommonWidgetTools.buildBottomButton(context,"提现", (){
				if (_mainFormKey.currentState.validate()) {
					AppData().withdrawRequest.amount = double.parse(amountController.text.trim());
					AppData().withdrawRequest.walletAddress = walletController.text.trim();
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
									  style: Theme.of(context).textTheme.bodyText2,
								  	controller: walletController,
								  	decoration: InputDecoration(
								  		icon: Icon(Icons.account_balance_wallet),
								  		labelText: '共创钱包地址',
								  		hintText: "请输入或长按粘贴地址"
								  	),
								  	validator: (String value) {
								  		if (!StringTools.ValidateWithdrawAddress(value.trim())) {
								  			return '请输入正确的提币地址';
								  		}
								  		return null;
								  	},
								  ),
								),
								SizedBox(
									width: 80,
									height: 40,
									child: Container(child: Center(child:
									OutlineButton(
										shape: StadiumBorder(),
										borderSide: BorderSide(color: Theme.of(context).primaryColor),
										onPressed: (){
										listBloc.getWithdrawAddress();
										showDialog(
											barrierDismissible: true,
											context: context,
											builder: (BuildContext context){
												return buildWithdrawListStreamBuilderView();
											}
										);
									},child: Text("选择",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).primaryColor)))))
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
						title: Text("请选择提现地址",style: Theme.of(context).textTheme.button),
						content: Center(
							child: SizedBox(
								width: 300,
								height: 300,
								child: Container(
									padding: EdgeInsets.symmetric(horizontal: 16),
									child: buildListData(snapshot),
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
	
	Widget buildListData(AsyncSnapshot<WithdrawAddressListResponse> snapshot) {
		if (snapshot.data.data.length > 0) {
			return ListView.separated(
				itemBuilder: (contest,index) => buildAddressItem(snapshot.data.data[index]),
				separatorBuilder: (context, index) => Divider(thickness: 1),
				itemCount: snapshot.data.data.length,
			);
		}
		return CommonWidgetTools.buildEmptyListPlaceholder(context);
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
				Text(title,style: Theme.of(context).textTheme.subtitle1,),
				Text(value,style: Theme.of(context).textTheme.bodyText2),
			],
		);
	}

	StreamBuilder buildBodyBuilderView() {
		return StreamBuilder<WithdrawAvailableResponse>(
			stream: withAvailableBloc.subject.stream,
			builder: (context, AsyncSnapshot<WithdrawAvailableResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
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

	Widget buildBody(WithdrawAvailableEntity withdrawAvailableEntity) {
		return Form(
			key: _mainFormKey,
		  child: ListView(
		  	children: <Widget>[
		  		buildWallet(),
		  		buildAmount(withdrawAvailableEntity),
		  		buildDescription(),
		  	],
		  ),
		);
	}

	Widget buildAmount(WithdrawAvailableEntity withdrawAvailableEntity) {
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
									  style: Theme.of(context).textTheme.bodyText2,
									  controller: amountController,
								  	decoration: InputDecoration(
								  		icon: Icon(Icons.monetization_on),
								  		labelText: '数量',
								  		hintText: "最小提现积分数量为10"
								  	),
								  	validator: (String value) {
								  		if (!StringTools.ValidateNumber(value.trim())) {
								  			return '请输入提现积分数量';
								  		}

								  		double amount = double.parse(value.trim());
								  		if (amount<0.01 || amount > withdrawAvailableEntity.available) {
								  			return "非法的提现数量";
										}

								  		return null;
								  	},
								  ),
								),
								SizedBox(
									width: 80,
									height: 40,
									child: Container(child: Center(child:
									OutlineButton(
										shape: StadiumBorder(),
										borderSide: BorderSide(color: Theme.of(context).primaryColor),
										onPressed: (){
										setState(() {
											amountController.text = "${withdrawAvailableEntity.available}";
										});
									},child: Text("全部",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).primaryColor)))))
								),
							],
						),
						Text("可提现积分: ${withdrawAvailableEntity.available}",style: Theme.of(context).textTheme.bodyText2),
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
						Expanded(child: Text("请务必输入正确的共创医保钱包地址，若因为个人失误导致资金丢失，平台概不负责。为了保证您的资金安全，我们会对提现申请进行人工审核，请耐心等待！",
							style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).errorColor))),
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
						Divider(thickness: 1),
						SizedBox(height: 16),
						Row(
							mainAxisAlignment: MainAxisAlignment.start,
							children: <Widget>[
								Text("短信验证码",style: Theme.of(context).textTheme.subtitle1),
							],
						),
						SizedBox(height: 16),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Expanded(
									child: Form(
										key: _dialogFormKey,
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
								),
								SizedBox(
									width: 100,
									height: 40,
									child: Container(
										padding: EdgeInsets.only(left: 16,right: 16),
										child: FlatButton(
											color: ColorTools.blue5677FC,
											shape: StadiumBorder(),
											onPressed: (){
												if (lastSendSmsTime != null) {
													var oneMinutesAgo = DateTime.now().subtract( Duration(seconds: 60));
													if (!lastSendSmsTime.isBefore(oneMinutesAgo)) {
														showDialog(
															context: context,
															builder: (BuildContext context){
																return AlertDialog(
																	content: Text("1分钟之内请勿连续操作",style: Theme.of(context).textTheme.button),
																);
															}
														);
														return;
													}
												}

												lastSendSmsTime = DateTime.now();
												CommonWidgetTools.showLoading(context);
												_apiRepository.smsSelf().then((value){
													Navigator.pop(context);
													if(value.data != null) {
														smsEntity = value.data;
														CommonWidgetTools.showAlertController(context, "验证码发送成功");
													} else {
														CommonWidgetTools.showAlertController(context, value.msg);
													}
												});
											},
											child: Text("发送",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))
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
											shape: StadiumBorder(),
											child: Text("取消",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).buttonColor)),
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
											shape: StadiumBorder(),
											color: ColorTools.green1AAD19,
											onPressed: (){
												if (_dialogFormKey.currentState.validate()) {
													if (!StringTools.ValidateSmsCode(verifyController.text.trim())) {
														CommonWidgetTools.showAlertController(context, "请输入正确的验证码");
														return;
													}
													AppData().withdrawRequest.verifyCode = verifyController.text.trim();

													CommonWidgetTools.showLoading(context);
													_apiRepository.applyWithdraw(AppData().withdrawRequest).then((value){
														CommonWidgetTools.dismissLoading(context);
														if(value.data != null) {
															CommonWidgetTools.showToastView(context, "提现请求发送成功");
															Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
															Navigator.push(context,
																MaterialPageRoute(builder: (context) => WithdrawHistoryView())
															);
														} else {
															CommonWidgetTools.showAlertController(context, value.msg);
														}
													});
												}
											}, child: Text("确认",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor)))
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