import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/views/waiverPage.dart';
import 'package:myapp/views/userProfile.dart';
import 'package:myapp/tools/stringTools.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/ProductInfoBloc.dart';
class CheckoutPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return CheckoutPageState();
	}
}

class CheckoutPageState extends State <CheckoutPage> {
	final _formKey = GlobalKey<FormState>();
	final amountController = TextEditingController();
	final _productInfoBloc = ProductInfoBloc();
	@override
	void initState() {
		super.initState();
		_productInfoBloc.productInfo();
		amountController.text = "1000";
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar:CommonWidgetTools.appBarWithTitleLeading(context, "下订单", (){
				Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
			}),
			drawer: UserProfilePage(),
			body: CenterView(),
			bottomNavigationBar: buildBottomView(),
		);
	}

	StreamBuilder buildBottomView() {
		return StreamBuilder<ProductResponse>(
			stream: _productInfoBloc.subject.stream,
			builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
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
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			width: width,
			height: 350,
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
			  					Text("算力单价"),
			  					Text("¥ ${productEntity.price} / U"),
			  				],
			  			),
			  		),
			  		Container(
			  			height: 40,
			  			child: Row(
			  				mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  				children: <Widget>[
			  					Text("数量 (U)"),
			  					Container(
			  						width: 200,
			  						child: Row(
			  							mainAxisAlignment: MainAxisAlignment.end,
			  							children: <Widget>[
			  								GestureDetector(
			  									child: SizedBox(
			  										width: 40,
			  									  height: 60,
			  									  child: Container(
			  										  color: Colors.white,
			  									  	child: Center(child: Text("-",style: TextStyle(color: Colors.grey)))
			  									  ),
			  									),
			  									onTap: (){
			  										var current = int.parse(amountController.text);
			  										if (current > 0) {
			  											var sub = current-1;
			  											setState(() {
			  												amountController.text = "$sub";
			  											});
			  										}
			  									},
			  								),
			  								SizedBox(
			  									width: 40,
			  								  height: 60,
			  								  child: Container(
			  									  decoration: BoxDecoration(
			  										  borderRadius: BorderRadius.circular(1),
			  									  ),
			  								  	child: TextFormField(
			  								  		controller: amountController,
			  								  		textAlign: TextAlign.center,
			  								  		onSaved: (String value) {

			  								  		},
			  								  		validator: (String value) {
			  								  			value = value.trim();
			  								  			if (!StringTools.ValidateNumber(value)) {
			  								  				return "请输入正确的数字";
			  								  			}
			  								  			return null;
			  								  		},
			  								  	),
			  								  ),
			  								),
			  								GestureDetector(
			  									child: SizedBox(
			  										width: 40,
			  										height: 60,
			  										child: Container(
			  											color: Colors.white,
			  											child: Center(child: Text("+",style: TextStyle(color: Colors.grey))))),
			  									onTap: (){
			  										var current = int.parse(amountController.text);
			  										if (current < 1000000) {
			  											var add = current+1;
			  											setState(() {
			  												amountController.text = "$add";
			  											});
			  										}
			  									},
			  								),
			  							],
			  						),
			  					)
			  				],
			  			),
			  		),
			  		Row(
			  			mainAxisAlignment: MainAxisAlignment.end,
			  		children: <Widget>[
			  			Text("每人每日限购${productEntity.limit_per_user}U")
			  		],
			  		),
			  		Row(
			  			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  			children: <Widget>[
			  				Text("每日总额 ${productEntity.total_supply} U"),
			  				Text("租赁进度: ${productEntity.sold_progress * 100}%"),
			  			],
			  		),
			  		SizedBox(height: 6),
			  		SizedBox(
			  			width: double.infinity,
			  		  child: Container(
			  		    child: LinearPercentIndicator(
			  		    	lineHeight: 8.0,
			  		    	percent: productEntity.sold_progress,
			  		    	progressColor: Colors.blue,
			  		    ),
			  		  ),
			  		),
			  		SizedBox(height: 10),
			  		Container(
			  			height: 40,
			  			child: Row(
			  				children: <Widget>[
			  					Expanded(child: Text("租赁周期为24小时,每U算力24小时大约可产生1个共创积分,24小时后，积分将自动发放到账户",style: TextStyle(color: Colors.red),)),
			  				],
			  			),
			  		),
			  		SizedBox(height: 30),
			  		Container(
			  			height: 40,
			  			child: Row(
			  				mainAxisAlignment: MainAxisAlignment.spaceBetween,
			  				children: <Widget>[
			  					Text("合计: ¥ ${productEntity.price * int.parse(amountController.text)}"),
			  					Column(
			  						children: <Widget>[
			  							Text("总额: ${productEntity.price * int.parse(amountController.text)}"),
			  						],
			  					),
			  				],
			  			),
			  		),
			  		buildBottomButtons(),
			  	],
			  ),
			),
		);
	}

	Widget buildBottomButtons() {
		var width = MediaQuery.of(context).size.width - 32;
		return Container(
			height: 60,
			width: width,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Expanded(
						child: OutlineButton(
							borderSide: BorderSide(
								color: Colors.grey,
								style: BorderStyle.solid,
								width: 2,
							),
							textColor: Colors.grey,
							child: Text("取消"),
							onPressed: (){
								Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
							},
						),
					),
					SizedBox(width: 20),
					Expanded(
						child: Container(
							child: FlatButton(
								color: ColorTools.green1AAD19,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
								onPressed: (){
									if (_formKey.currentState.validate()) {
										_formKey.currentState.save();
										AppData().orderRequest.amount = int.parse(amountController.text);
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => WaiverPage()),
										);
									}
								},
								child: Text("确认租赁",style: TextStyle(color: Colors.white),)
							)
						),
					),
				],
			),
		);
	}
}