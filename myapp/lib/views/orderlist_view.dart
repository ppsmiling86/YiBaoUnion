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

	Widget build24Hours() {
		return Text("共创算力租赁 * 24小时",style: Theme.of(context).textTheme.bodyText2);
	}

	Widget buildOrderStatus(String status) {
		return Text(status,style: Theme.of(context).textTheme.bodyText2);
	}

	Widget buildPriceText(PlaceOrderEntity placeOrderEntity) {
		return Text("¥ ${placeOrderEntity.price}", style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).errorColor));
	}

	Widget buildCreditTest(PlaceOrderEntity placeOrderEntity) {
		return Text(" x ${placeOrderEntity.amount} U",style: Theme.of(context).textTheme.bodyText2);
	}

	Widget buildOrderNumber(PlaceOrderEntity placeOrderEntity) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Text("订单号: ${placeOrderEntity.id}",style: Theme.of(context).textTheme.bodyText2),
				Text("总计",style: Theme.of(context).textTheme.bodyText2),
			],
		);
	}

	Widget buildOrderCreatedAt(PlaceOrderEntity placeOrderEntity) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Text("${DateTools.ConvertDateToString(placeOrderEntity.created_at)}",style: Theme.of(context).textTheme.bodyText2),
				Text("¥ ${placeOrderEntity.value}",style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).errorColor)),
			],
		);
	}

	Widget buildAlreadyGenerateCredit(PlaceOrderEntity placeOrderEntity) {
		return Row(
			children: <Widget>[
				RichText(text: TextSpan(
					text: "已挖矿生产共创积分: ",
					style: Theme.of(context).textTheme.bodyText2,
					children: [
						TextSpan(
							text: "${placeOrderEntity.mined_score}",
							style: Theme.of(context).textTheme.bodyText2.copyWith(color: Theme.of(context).errorColor),
						)
					]
				)),
			],
		);
	}

	Widget buildPersentage(PlaceOrderEntity placeOrderEntity) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: <Widget>[
				LinearPercentIndicator(
					width: MediaQuery.of(context).size.width - 68,
					lineHeight: 6.0,
					percent: placeOrderEntity.progress,
					progressColor: Theme.of(context).primaryColor,
				),
				Text("${placeOrderEntity.progress * 100}%",style: Theme.of(context).textTheme.bodyText2),
			],
		);
	}

	Widget buildPendingToPay(PlaceOrderEntity placeOrderEntity) {
		return Row(
			children: <Widget>[
				Expanded(
					child: SizedBox(
						height: 30,
					  child: FlatButton(
					  	color: ColorTools.redE64340,
					  	shape: StadiumBorder(),
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
					  	child: Text("取消",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor)),
					  ),
					)
				),
				SizedBox(width: 16),
				Expanded(
					child: SizedBox(
						height: 30,
					  child: FlatButton(
					  	color: ColorTools.green1AAD19,
					  	shape: StadiumBorder(),
					  	onPressed: (){
					  		Navigator.push(
					  			context,
					  			MaterialPageRoute(builder: (context) => PaymentView(placeOrderEntity)),
					  		);
					  	},
					  	child: Text("去支付",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor)),
					  ),
					)
				)
			],
		);
	}

  Widget buildOrderInProgress(PlaceOrderEntity placeOrderEntity) {
		return Container(
			height: 172,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Row(
						children: <Widget>[
							Container(
								width: 70,
								height: 70,
								child: Image(image: AssetImage(ImageTools.product)),
							),
							SizedBox(width: 30),
							Expanded(child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: <Widget>[
											build24Hours(),
											buildOrderStatus("挖矿中"),
										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											buildPriceText(placeOrderEntity),
											buildCreditTest(placeOrderEntity),
										],
									)
								],
							)
							),
						],
					),
					buildOrderNumber(placeOrderEntity),
					buildOrderCreatedAt(placeOrderEntity),
					SizedBox(height: 10),
					buildAlreadyGenerateCredit(placeOrderEntity),
					buildPersentage(placeOrderEntity),
					Divider(thickness: 1),
				],
			),
		);
  }

	Widget buildOrderCompleted(PlaceOrderEntity placeOrderEntity) {
		return Container(
			height: 182,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Row(
						children: <Widget>[
							Container(
								width: 70,
								height: 70,
								child: Image(image: AssetImage(ImageTools.product)),
							),
							SizedBox(width: 30),
							Expanded(child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: <Widget>[
											build24Hours(),
											buildOrderStatus("积分已发放"),

										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											buildPriceText(placeOrderEntity),
											buildCreditTest(placeOrderEntity),
										],
									)
								],
							)
							),
						],
					),
					buildOrderNumber(placeOrderEntity),
					SizedBox(height: 5),
					buildOrderCreatedAt(placeOrderEntity),
					SizedBox(height: 5),
					buildAlreadyGenerateCredit(placeOrderEntity),
					SizedBox(height: 10),
					buildPersentage(placeOrderEntity),
					Divider(thickness: 1),
				],
			),
		);
	}

	Widget buildOrderPendingToPay(PlaceOrderEntity placeOrderEntity) {
		return Container(
			height: 172,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Row(
						children: <Widget>[
							Container(
								width: 70,
								height: 70,
								child: Image(image: AssetImage(ImageTools.product)),
							),
							SizedBox(width: 30),
							Expanded(child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: <Widget>[
											build24Hours(),
											buildOrderStatus("待支付"),
										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											buildPriceText(placeOrderEntity),
											buildCreditTest(placeOrderEntity),
										],
									)
								],
							)
							),
						],
					),
					buildOrderNumber(placeOrderEntity),
					buildOrderCreatedAt(placeOrderEntity),
					SizedBox(height: 10),
					buildPendingToPay(placeOrderEntity),
					Divider(thickness: 1),
				],
			),
		);
	}

	Widget buildOrderCanceled(PlaceOrderEntity placeOrderEntity) {
		return Container(
			height: 140,
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					Row(
						children: <Widget>[
							Container(
								width: 70,
								height: 70,
								child: Image(image: AssetImage(ImageTools.product)),
							),
							SizedBox(width: 30),
							Expanded(child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										children: <Widget>[
											build24Hours(),
											buildOrderStatus("已取消"),
										],
									),
									Row(
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											buildPriceText(placeOrderEntity),
											buildCreditTest(placeOrderEntity),
										],
									)
								],
							)
							),
						],
					),
					buildOrderNumber(placeOrderEntity),
					SizedBox(height: 10),
					buildOrderCreatedAt(placeOrderEntity),
					Divider(thickness: 1),
				],
			),
		);
	}
}