import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myapp/tools/colorTools.dart';
import 'payment_view.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/models/getOrderBloc.dart';
import 'package:myapp/tools/dateTools.dart';
import 'package:myapp/models/ApiRepository.dart';


class OrderStatus  {
	static final canceled = -2;
	static final payFail = -1;
	static final pendingToPay = 0;
	static final working = 1;
	static final completed = 2;
}



class OrderListView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return OrderListViewState();
  }
}

class OrderListViewState extends State <OrderListView>{
	final bloc = GetOrderBloc();
	final _apiRepository = ApiRepository();

	@override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

	@override
  Widget build(BuildContext context) {
		bloc.getOrder();
    return Scaffold(
		appBar: CommonWidgetTools.appBarWithTitle(context, "订单列表"),
		body: buildStreamBuilderView(),
	);
  }

	StreamBuilder buildStreamBuilderView() {
		return StreamBuilder<GetOrderResponse>(
			stream: bloc.subject.stream,
			builder: (context, AsyncSnapshot<GetOrderResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					return Container(
						child: buildListData(snapshot),
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
	
	Widget buildListData(AsyncSnapshot<GetOrderResponse> snapshot) {
		if (snapshot.data.data.length > 0) {
			return ListView.builder(
				itemCount: snapshot.data.data.length,
				itemBuilder: (context,index) {
					PlaceOrderEntity placeOrderEntity = snapshot.data.data[index];
					if (placeOrderEntity.status == OrderStatus.working) {
						return buildOrderInProgress(placeOrderEntity);
					} else if (placeOrderEntity.status == OrderStatus.completed) {
						return buildOrderCompleted(placeOrderEntity);
					} else if (placeOrderEntity.status == OrderStatus.pendingToPay) {
						return buildOrderPendingToPay(placeOrderEntity);
					} else if (placeOrderEntity.status == OrderStatus.canceled) {
						return buildOrderCanceled(placeOrderEntity);
					} else {
						return Container();
					}
				});
		}
		return CommonWidgetTools.buildEmptyListPlaceholder(context);
	}
	

  Widget buildOrderInProgress(PlaceOrderEntity placeOrderEntity) {
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
							Text("总计"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}"),
							Text("¥ ${placeOrderEntity.value}",style: TextStyle(color: Colors.red)),
						],
					),
					Row(
						children: <Widget>[
							RichText(text: TextSpan(
								text: "已挖矿生产共创积分:",
								children: [
									TextSpan(
										text: "${placeOrderEntity.mined_score}",
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
								percent: placeOrderEntity.progress,
								progressColor: Colors.blue,
							),
							Text("${placeOrderEntity.progress * 100}%"),
						],
					),
				],
			),
		);
  }

	Widget buildOrderCompleted(PlaceOrderEntity placeOrderEntity) {
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
							Text("总计"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}"),
							Text("¥ ${placeOrderEntity.value}",style: TextStyle(color: Colors.red)),
						],
					),
					Row(
						children: <Widget>[
							RichText(text: TextSpan(
								text: "已挖矿生产共创积分:",
								children: [
									TextSpan(
										text: "${placeOrderEntity.mined_score}",
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
								percent: placeOrderEntity.progress,
								progressColor: Colors.blue,
							),
							Text("${placeOrderEntity.progress * 100}%"),
						],
					),
				],
			),
		);
	}

	Widget buildOrderPendingToPay(PlaceOrderEntity placeOrderEntity) {
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
							Text("总计"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}"),
							Text("¥ ${placeOrderEntity.value}",style: TextStyle(color: Colors.red)),
						],
					),
					Row(
						children: <Widget>[
							Expanded(
								child: FlatButton(
									color: ColorTools.redE64340,
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(2)
									),
									onPressed: (){
										CommonWidgetTools.showLoading(context);
										_apiRepository.cancelOrder(placeOrderEntity.id).then((value){
											CommonWidgetTools.dismissLoading(context);
											if (value.msg == null) {
												setState(() {

												});
											} else {
												CommonWidgetTools.showAlertController(context, value.msg);
											}
										});
									},
									child: Text("取消",style: TextStyle(color: ColorTools.whiteFFFFFF)),
								)
							),
							SizedBox(width: 16),
							Expanded(
								child: FlatButton(
									color: ColorTools.green1AAD19,
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(2)
									),
									onPressed: (){
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => PaymentView(placeOrderEntity)),
										);
									},
									child: Text("去支付",style: TextStyle(color: Colors.white)),
								)
							)
						],
					)
				],
			),
		);
	}

	Widget buildOrderCanceled(PlaceOrderEntity placeOrderEntity) {
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
							Text("总计"),
						],
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: <Widget>[
							Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}"),
							Text("¥ ${placeOrderEntity.value}",style: TextStyle(color: Colors.red)),
						],
					),
				],
			),
		);
	}
}