import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myapp/tools/colorTools.dart';
import 'payment_view.dart';

class OrderListView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return OrderListViewState();
  }
}

class OrderListViewState extends State <OrderListView>{
	@override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
				Navigator.of(context).pop();
			}),
			title: Text("订单列表"),
		),
		body: ListView(
			children: <Widget>[
				SizedBox(height: 16),
				buildOrderInProgress(),
				buildOrderCompleted(),
				buildOrderPendingToPay(),
				buildOrderCanceled(),
				SizedBox(height: 16),
			],
		),
	);
  }

  Widget buildOrderInProgress() {
		return Container(
			height: 200,
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
											Text("挖矿中"),
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
					Row(
						children: <Widget>[
							RichText(text: TextSpan(
								text: "已挖矿生产共创积分:",
								children: [
									TextSpan(
										text: "50.66",
										style: TextStyle(color: Colors.red),
									)
								]
							)),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							LinearPercentIndicator(
								width: 100.0,
								lineHeight: 8.0,
								percent: 0.5,
								progressColor: Colors.blue,
							),
							Text("50%"),
						],
					),
				],
			),
		);
  }

	Widget buildOrderCompleted() {
		return Container(
			height: 200,
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
											Text("积分已发放"),
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
					Row(
						children: <Widget>[
							RichText(text: TextSpan(
								text: "已挖矿生产共创积分:",
								children: [
									TextSpan(
										text: "50.66",
										style: TextStyle(color: Colors.red),
									)
								]
							)),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							LinearPercentIndicator(
								width: 100.0,
								lineHeight: 8.0,
								percent: 1.0,
								progressColor: Colors.blue,
							),
							Text("100%"),
						],
					),
				],
			),
		);
	}

	Widget buildOrderPendingToPay() {
		return Container(
			height: 200,
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
					Row(
						children: <Widget>[
							Expanded(
								child: FlatButton(
									color: ColorTools.green1AAD19,
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(2)
									),
									onPressed: (){
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => PaymentView()),
										);
									},
									child: Text("去支付",style: TextStyle(color: Colors.white)),
								)
							),
						],
					)
				],
			),
		);
	}

	Widget buildOrderCanceled() {
		return Container(
			height: 200,
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
											Text("已取消"),
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
				],
			),
		);
	}
}