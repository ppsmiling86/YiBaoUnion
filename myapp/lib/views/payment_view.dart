import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:myapp/views/orderlist_view.dart';
import 'contact_customer_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/dateTools.dart';
import 'package:myapp/models/AppData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:myapp/models/ApiRepository.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class PaymentView extends StatefulWidget {
	final PlaceOrderEntity placeOrderEntity;

	PaymentView(this.placeOrderEntity);
	@override
	State<StatefulWidget> createState() {
		return PaymentViewState();
	}
}

enum PaymentType {
	aliPay,
	wechatPay,
}


class PaymentViewState extends State <PaymentView> {
	PaymentType selectPaymentType = PaymentType.aliPay;
	Timer _timer;
	final _apiRepository = ApiRepository();
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "订单支付"),
			body: ListView(
				children: <Widget>[
					buildOrderPendingToPay(this.widget.placeOrderEntity),
				],
			),
			bottomNavigationBar: buildBottomButton(this.widget.placeOrderEntity),
		);
	}

	Widget buildOrderPendingToPay(PlaceOrderEntity placeOrderEntity) {
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
											Text("¥ ${placeOrderEntity.price}", style: TextStyle(color: Colors.red)),
											Text(" x ${placeOrderEntity.amount} U")
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
							Text("订单号: ${placeOrderEntity.id}"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}"),
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

	int paymentTypeIntByType(PaymentType type) {
		if (type == PaymentType.aliPay) {
			return 1;
		}

		if (type == PaymentType.wechatPay) {
			return 2;
		}

		return 0;
	}

	Widget buildBottomButton(PlaceOrderEntity placeOrderEntity) {
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
											text: "¥ ${placeOrderEntity.value}",
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
											CommonWidgetTools.showLoading(context);
											_apiRepository.payOrder(placeOrderEntity.id, paymentTypeIntByType(selectPaymentType)).then((value){
												CommonWidgetTools.dismissLoading(context);
												if(value.data != null) {
													launchURL(value.data.pay_url);
													poolingPaymentResponse(placeOrderEntity);
													showDialog(context: context,
														barrierDismissible: false,
														builder: (_) => AlertDialog(
															title: Text("等待支付结果"),
															content: SizedBox(
																width: 40,
																height: 40,
																child: Center(
																	child: Container(
																		width: 20,
																		height: 20,
																		child: CircularProgressIndicator(),
																	),
																),
															),
															actions: <Widget>[
																FlatButton(onPressed: (){
																	_timer.cancel();
																	Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
																	Navigator.push(context,
																		MaterialPageRoute(builder: (context) => OrderListView())
																	);
																}, child: Text("支付成功")),
																FlatButton(onPressed: (){
																	_timer.cancel();
																	Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
																	Navigator.push(context,
																		MaterialPageRoute(builder: (context) => ContactCustomerServiceView())
																	);
																}, child: Text("支付遇到问题?")),
															],
														),
													);
												} else {
													CommonWidgetTools.showAlertController(context, value.msg);
												}
											});
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

	void launchURL(String urlStr) async {
		html.window.location.assign(urlStr);



//		if (await canLaunch(urlStr)) {
//			await launch(urlStr,forceWebView: true);
//		} else {
//			throw 'Could not launch $urlStr';
//		}
	}

	void poolingPaymentResponse(PlaceOrderEntity placeOrderEntity) {
		_timer = Timer.periodic(Duration(seconds: 3), (timer){
			_apiRepository.payStatus(placeOrderEntity.id).then((value){
				if (value.data.status == 1) { // 成功
					timer.cancel();
					Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
					Navigator.push(context,
						MaterialPageRoute(builder: (context) => OrderListView())
					);
				} else if (value.data.status == 0) { // 等待中

				} else if (value.data.status == -1) { // 失败
					timer.cancel();
					CommonWidgetTools.showAlertControllerOnTap(context, "支付失败: ${value.msg}", (){
						Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
						Navigator.push(context,
							MaterialPageRoute(builder: (context) => OrderListView())
						);
					});
				}
			});
		});
	}

}