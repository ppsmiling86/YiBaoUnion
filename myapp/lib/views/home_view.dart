import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/custom_views/center_view.dart';
import 'package:myapp/models/Response.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'userProfile.dart';
import 'registrationPage.dart';
import 'package:myapp/models/AppData.dart';
import 'checkoutPage.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/models/CatalogsBloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return HomeViewState();
	}
}

class HomeViewState extends State<HomeView> {
	final bloc = CatalogsBloc();
	@override
	void initState() {
		super.initState();
		bloc.getCatalogs();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: Builder(builder: (context) =>
					IconButton(
						icon: CircleAvatar(
							child: Icon(Icons.person),
						),
						onPressed: (){
							Scaffold.of(context).openDrawer();
						})
				),
			),
			drawer: UserProfilePage(),
			body: CenterView(),
//			body: StreamBuilder<CatalogResponse>(
//				stream: bloc.subject.stream,
//				builder: (context, AsyncSnapshot<CatalogResponse> snapshot) {
//					print(snapshot);
//					if (snapshot.hasData) {
//						if (snapshot.data.code != 200 && snapshot.data.message.length > 0) {
//							return Container();
//						}
//						return buildCatalogResponse(snapshot.data);
//					} else if (snapshot.hasError) {
//						return Container();
//					} else {
//						return Container(
//							child: Center(child: Text("test:)")),
//						);
//					}
//				}),
			bottomNavigationBar: buildBottomButtons(),
		);
	}

	Widget buildCatalogResponse(CatalogResponse response) {
		print(response);
		return Container(
			child: Center(child: Text("test:)")),
		);
	}

	Widget buildBottomButtons() {
		return Container(
			height: 80,
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
			child: Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					Expanded(
						flex: 1,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text("今日认租: 30%"),
								LinearPercentIndicator(
									width: 100.0,
									lineHeight: 8.0,
									percent: 0.3,
									progressColor: Colors.blue,
								),
							],
						),
					),
					Expanded(
						flex: 2,
						child: SizedBox(
							height: 60,
							child: FlatButton(
								color: ColorTools.green1AAD19,
								shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
								onPressed: (){
									if (AppData().loginUser().isLoggedIn) {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => CheckoutPage()),
										);
									} else {
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => RegistrationPage()),
										);
									}
								},
								child: Text("立即租赁算力",style: TextStyle(color: Colors.white))
							),
						),
					),
				],
			),
		);
	}
}