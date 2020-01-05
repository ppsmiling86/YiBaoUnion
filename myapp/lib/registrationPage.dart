import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'waiverPage.dart';
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
				title: Text("注册"),
			),
			body: Container(
				height: 400,
				child: Form(
					key: _formKey,
					child: ListView(
						children: <Widget>[
							SizedBox(height: 40),
							buildPhoneTextField(),
							SizedBox(height: 40),
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
			height: 60,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Container(
						width: width,
						child: TextFormField(
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
			height: 60,
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
						AppData().loginUser.login(AppData().tempRegistration);
						Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => WaiverPage()),
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