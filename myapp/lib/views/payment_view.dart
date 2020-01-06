import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:ant_icons/ant_icons.dart';

class PaymentView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		// TODO: implement createState
		return PaymentViewState();
	}
}

enum PaymentType {
	aliPay,
	wechatPay,
}


class PaymentViewState extends State {
	PaymentType selectPaymentType = PaymentType.aliPay;
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text("订单支付",style: TextStyle(fontWeight: FontWeight.w500),),
				centerTitle: true,
			),
			body: ListView(
				children: <Widget>[
					buildOrderPendingToPay(),
				],
			),
			bottomNavigationBar: buildBottomButton(),
		);
	}

	Widget buildOrderPendingToPay() {
		return Container(
			height: 400,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Row(
						children: <Widget>[
							Text("共创算力订单")
						],
					),
					Divider(),
					Row(
						children: <Widget>[
							Container(
								width: 70,
								height: 70,
								child: Image(image: AssetImage(ImageTools.placeholder1)),
							),
							SizedBox(width: 30),
							Expanded(child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: <Widget>[
											Text("共创算力租赁 * 24小时"),
											Text("待支付"),
										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											Text("¥ 100", style: TextStyle(color: Colors.red)),
											Text("x 1000 U")
										],
									)
								],
							)
							),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("订单号: 123456789"),
							Text("总计"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("2020.10.20 12:30:30"),
							Text("¥ 100000.00",style: TextStyle(color: Colors.red)),
						],
					),
					Divider(),
					Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Text("支付方式",style: TextStyle(color: Colors.grey),),
							SizedBox(width: 16),
							Text(paymentTypeStringByType(selectPaymentType),style: TextStyle(color: Colors.black))
						],
					),
					Divider(),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							SizedBox(
								width: 200,
							  child: Row(
								  mainAxisAlignment: MainAxisAlignment.start,
							  	children: <Widget>[
							  		Icon(AntIcons.alipay_square,size: 25),
							  		SizedBox(width: 16),
							  		Text("支付宝"),
							  	],
							  ),
							),
							Checkbox(
								value: selectPaymentType == PaymentType.aliPay,
								onChanged: (bool value) {
									setState(() {
										if (value) {
											selectPaymentType = PaymentType.aliPay;
										}
									});
								},
							),
						],
					),
					Divider(),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							SizedBox(
								width: 200,
							  child: Row(
							  	children: <Widget>[
							  		Icon(AntIcons.wechat,size: 25),
							  		SizedBox(width: 16),
							  		Text("微信支付"),
							  	],
							  ),
							),
							Checkbox(
								value: selectPaymentType == PaymentType.wechatPay,
								onChanged: (bool value) {
									setState(() {
										if (value) {
											selectPaymentType = PaymentType.wechatPay;
										}
									});
								},
							),
						],
					)
				],
			),
		);
	}

	String paymentTypeStringByType(PaymentType type) {
		if (type == PaymentType.aliPay) {
			return "支付宝";
		}

		if (type == PaymentType.wechatPay) {
			return "微信";
		}

		return "";
	}

	Widget buildBottomButton() {
		return Container(
			height: 100,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Divider(),
					Container(
						padding: EdgeInsets.symmetric(horizontal: 16),
						height: 60,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								RichText(text: TextSpan(
									text: "总计:",
									children: [
										TextSpan(
											text: "¥ 100000.00",
											style: TextStyle(color: Colors.red),
										)
									]
								)
								),
								Container(
									width: 170,
									child: FlatButton(
										shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
										color: Colors.red,
										onPressed: (){

										},
										child: Text("立即支付",style: TextStyle(color: Colors.white)),
									),
								),
							],
						),
					),
					Divider(),
				],
			),
		);
	}
}