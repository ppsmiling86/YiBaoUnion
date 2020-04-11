import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/views/payment_view.dart';
import 'package:myapp/views/userProfile.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/ProductInfoBloc.dart';
import 'package:myapp/tools/numberTools.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:myapp/models/ApiRepository.dart';

class CheckoutPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return CheckoutPageState();
	}
}

class CheckoutPageState extends State <CheckoutPage> {
	final _apiRepository = ApiRepository();
	final _formKey = GlobalKey<FormState>();
	final amountController = TextEditingController();
	final _productInfoBloc = ProductInfoBloc();
	@override
	void initState() {
		super.initState();
		amountController.text = "1";
	}

	@override
	Widget build(BuildContext context) {
		_productInfoBloc.productInfo();
		return Scaffold(
			appBar:CommonWidgetTools.appBarWithTitleLeading(context, "下订单", (){
				Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
			}),
			drawer: UserProfilePage(),
			body: Stack(
				children: <Widget>[
					CenterView(),
					buildMask(),
				],
			),
			bottomNavigationBar: SingleChildScrollView(
				child: buildBottomView(),
			),
			resizeToAvoidBottomInset: false,
			resizeToAvoidBottomPadding: false,
		);
	}
	
	Widget buildMask() {
		return Container(
			color: Colors.black.withOpacity(0.5),
		);
	}

	StreamBuilder buildBottomView() {
		return StreamBuilder<ProductResponse>(
			stream: _productInfoBloc.subject.stream,
			builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData && snapshot.data.data is ProductEntity) {
					return buildProductDetail(snapshot.data.data);
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

	Widget buildBody() {
		var width = MediaQuery.of(context).size.width - 32;
		var height = MediaQuery.of(context).size.height - 300;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			width: width,
			height: height,
			child: ListView(
				children: <Widget>[
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder1)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder2)
					),
					Image(
						width: width,
						fit: BoxFit.fill,
						image: AssetImage(ImageTools.placeholder3)
					),
				],
			),
		);
	}

	Widget buildProductDetail(ProductEntity productEntity) {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			padding:  EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
			width: width,
			height: 285,
			child: Form(
				key: _formKey,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
						Container(
							height: 40,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("单价",style: Theme.of(context).textTheme.subtitle1),
									Row(
										mainAxisAlignment: MainAxisAlignment.end,
										children: <Widget>[
											Text("¥ ${productEntity.price}",style: Theme.of(context).textTheme.bodyText2),
											SizedBox(width: 5),
										],
									)
								],
							),
						),
						Container(
							height: 40,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget>[
									Text("数量 (U)",style: Theme.of(context).textTheme.subtitle1),
									Container(
										width: 200,
										child: Row(
											crossAxisAlignment: CrossAxisAlignment.center,
											mainAxisAlignment: MainAxisAlignment.end,
											children: <Widget>[
												GestureDetector(
													onTap: (){
														if (StringTools.ValidateNumber(amountController.text)) {
															var current = int.parse(amountController.text);
															if (current > 0) {
																var sub = current - 1;
																setState(() {
																	amountController.text = "$sub";
																});
															}
														}
													},
													child: Image(image: AssetImage(ImageTools.minus),width: 36,height: 36,color: Theme.of(context).indicatorColor)
												),
												SizedBox(
													width: 40,
													child: Container(
														decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(1),
														),
														padding: EdgeInsets.only(bottom: 7),
														child: TextFormField(
															controller: amountController,
															textAlign: TextAlign.center,
															validator: (String value) {
																value = value.trim();
																if (!StringTools.ValidateNumber(value)) {
																	CommonWidgetTools.showAlertController(context, "请输入正确的数字");
																	AppData().orderRequest.amount = 0;
																	return null;
																}
																int amount = int.parse(value);
																if (amount < 1 || amount > productEntity.limit_per_user) {
																	CommonWidgetTools.showAlertController(context, "购买量必须大于0，小于最大可购买量");
																	AppData().orderRequest.amount = 0;
																	return null;
																}

																print("${amount}");
																AppData().orderRequest.amount = amount;
																return null;
															},
														),
													),
												),
												GestureDetector(
													onTap: (){
														if (StringTools.ValidateNumber(amountController.text)) {
															var current = int.parse(amountController.text);
															if (current < productEntity.limit_per_user) {
																var add = current+1;
																setState(() {
																	amountController.text = "$add";
																});
															}
														}
													},
													child: Image(image: AssetImage(ImageTools.plus),width: 36,height: 36,color: Theme.of(context).indicatorColor)),
											],
										),
									)
								],
							),
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.end,
							children: <Widget>[
								Text("每日限购${productEntity.limit_per_user}",style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).errorColor)),
								SizedBox(width: 20),
							],
						),
						SizedBox(height: 6),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Text("今日剩余 ${productEntity.left} / ${productEntity.total_supply}",style: Theme.of(context).textTheme.subtitle1),
							],
						),
						SizedBox(height: 6),
						SizedBox(
							width: double.infinity,
							child: Container(
								child: LinearPercentIndicator(
									lineHeight: 8.0,
									percent: productEntity.sold_progress,
									progressColor: Theme.of(context).primaryColor,
								),
							),
						),
						SizedBox(height: 6),
						Container(
							height: 40,
							child: Row(
								children: <Widget>[
									Expanded(child: Text("租赁周期为24小时,每U算力每小时大约可产生${productEntity.score_per_unithour}个共创积分,整点发放",style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).errorColor))),
								],
							),
						),
						Container(
							height: 40,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									RichText(text: TextSpan(
										text: "合计: ",
										style: Theme.of(context).textTheme.subtitle1,
										children: [
											TextSpan(
												text: "¥ ${productEntity.price * int.parse(amountController.text)}",
												style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).errorColor)
											)
										]
									))
								],
							),
						),
						buildBottomButtons(productEntity),
					],
				),
			),
		);
	}

	Widget buildBottomButtons(ProductEntity productEntity) {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 3),
			height: 40,
			width: width,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Expanded(
						child: OutlineButton(
							shape: StadiumBorder(),
							borderSide: BorderSide(color: Theme.of(context).buttonColor),
							child: Text("取消",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).buttonColor)),
							onPressed: (){
								Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
							},
						),
					),
					SizedBox(width: 20),
					Expanded(
						child: Container(
							child: FlatButton(
								color: Theme.of(context).buttonColor,
								shape: StadiumBorder(),
								onPressed: (){
									if (_formKey.currentState.validate()) {
										if (AppData().orderRequest.amount > 0 && AppData().orderRequest.amount <= productEntity.limit_per_user) {

											CommonWidgetTools.showLoading(context);
											print("place order amount ${AppData().orderRequest.amount}");
											_apiRepository.placeOrder(AppData().orderRequest.amount).then((value){
												CommonWidgetTools.dismissLoading(context);
												if (value.data is PlaceOrderEntity) {
													print("place order success, order id is: ${value.data.id}");
													Navigator.push(
														context,
														MaterialPageRoute(builder: (context) => PaymentView(value.data)),
													);
												} else {
													print("error is ${value.msg}");
													CommonWidgetTools.showAlertController(context, value.msg);
												}
											});
										}
									}
								},
								child: Text("确认租赁",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))
							)
						),
					),
				],
			),
		);
	}
}