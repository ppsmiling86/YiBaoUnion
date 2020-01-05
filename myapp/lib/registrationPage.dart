import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'checkoutPage.dart';
import 'stringTools.dart';
import 'AppData.dart';

class RegistrationPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return RegistrationPageState();
	}
}

class RegistrationPageState extends State <RegistrationPage> {
	final _formKey = GlobalKey<FormState>();
	var phoneController = TextEditingController();

	DateTime lastSendSmsTime;

	@override
  void dispose() {
    super.dispose();
	phoneController.dispose();
  }
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(
					icon: Icon(Icons.arrow_left),
					onPressed: (){
						Navigator.of(context).pop();
					},
				),
				centerTitle: true,
				title: Text("登陆"),
			),
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
							if (!StringTools.ValidateSmsCode(phoneController.value.text)) {
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
							showDialog(
								context: context,
								builder: (BuildContext context){
									return AlertDialog(
										content: Text("验证码发送成功"),
									);
								}
							);
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
						AppData().loginUser().login(AppData().tempRegistration);
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => CheckoutPage()),
						);
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