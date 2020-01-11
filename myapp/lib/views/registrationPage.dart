import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'checkoutPage.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/models/UserBloc.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/localStorageTools.dart';
class RegistrationPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return RegistrationPageState();
	}
}

class RegistrationPageState extends State <RegistrationPage> {
	final _formKey = GlobalKey<FormState>();
	var phoneController = TextEditingController();
	SMSEntity smsEntity;
	UserBloc userBloc = UserBloc();
	DateTime lastSendSmsTime;

	@override
	void dispose() {
		super.dispose();
		phoneController.dispose();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "登陆"),
			body: Container(
				height: 500,
				child: Form(
					key: _formKey,
					child: ListView(
						children: <Widget>[
							buildPhoneTextField(),
							buildSendVerifyCodeField(),
						],
					),
				),
			),
			bottomNavigationBar: buildLoginButton(),
		);
	}



	Widget buildPhoneTextField() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			height: 110,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Container(
						width: width,
						child: TextFormField(
							controller: phoneController,
							decoration: InputDecoration(
								icon: Icon(Icons.phone),
								labelText: '手机号:',
							),
							onSaved: (String value) {
								AppData().tempRegistration.mobile = value;
							},
							validator: (String value) {
								value = value.trim();
								if (!StringTools.ValidatePhoneNumber(value)) {
									return "请输入正确的手机号码";
								}
								return null;
							},
						),
					),
				],
			),
		);
	}

	Widget buildSendVerifyCodeField() {
		var width = MediaQuery.of(context).size.width - 150;
		return Container(
			height: 110,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Container(
						width: width,
						child: TextFormField(
							decoration: InputDecoration(
								icon: Icon(Icons.sms),
								labelText: '验证码:',
							),
							onSaved: (String value) {
								AppData().tempRegistration.verifyCode = value;
							},
							validator: (String value) {
								value = value.trim();
								if (!StringTools.ValidateSmsCode(value)) {
									return "请输入正确的验证码";
								}
								return null;
							},
						),
					),
					OutlineButton(
						child: Text("发送验证码"),
						onPressed: (){
							if (!StringTools.ValidatePhoneNumber(phoneController.value.text)) {
								showDialog(
									context: context,
									builder: (BuildContext context){
										return AlertDialog(
											content: Text("请输入正确的手机号码"),
										);
									}
								);
								return;
							}

							if (lastSendSmsTime != null) {
								var oneMinutesAgo = DateTime.now().subtract( Duration(seconds: 60));
								if (!lastSendSmsTime.isBefore(oneMinutesAgo)) {
									showDialog(
										context: context,
										builder: (BuildContext context){
											return AlertDialog(
												content: Text("1分钟之内请勿连续操作"),
											);
										}
									);
									return;
								}
							}

							lastSendSmsTime = DateTime.now();
							CommonWidgetTools.showLoading(context);
							AppData().loginUser().sms(AppData().tempRegistration).then((value){
								Navigator.pop(context);
								if(value.data != null) {
									smsEntity = value.data;
									CommonWidgetTools.showAlertController(context, "验证码发送成功");
								} else {
									CommonWidgetTools.showAlertController(context, value.msg);
								}
							});
						}),
				],
			),
		);
	}

	Widget buildLoginButton() {
		return Container(
			height: 70,
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			child: GestureDetector(
				onTap: (){
					if (_formKey.currentState.validate()) {
						_formKey.currentState.save();

//						if (smsEntity == null || smsEntity.code != AppData().tempRegistration.verifyCode) {
//							CommonWidgetTools.showAlertController(context, "请输入正确的验证码");
//							return;
//						}

						CommonWidgetTools.showLoading(context);
						var upperInviteCode = LocalStorageTools.getUpperInviteCode();
						print("use upper invite code:${upperInviteCode}");
						AppData().tempRegistration.inviteCode = upperInviteCode;
						AppData().loginUser().login(AppData().tempRegistration).then((value){
							Navigator.pop(context);
							if(value.data != null) {
								Navigator.push(
									context,
									MaterialPageRoute(builder: (context) => CheckoutPage()),
								);
							} else {
								CommonWidgetTools.showAlertController(context, value.msg);
							}
						});
					}
				},
				child: Container(
					height: 50,
					color: Colors.blueAccent,
					child: Center(
						child: Text("登陆",style: TextStyle(color: Colors.white)),
					),
				),
			),
		);
	}

}