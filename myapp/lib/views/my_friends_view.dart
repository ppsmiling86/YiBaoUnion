import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class MyFriendsView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return MyFriendsViewState();
	}
}

class MyFriendsViewState extends State<MyFriendsView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "我的好友"),
			body: ListView.separated(
				itemBuilder: (contest,index) {
					if (index == 0) {
						return buildSummary();
					} else {
						return buildListItem();
					}
				},
				separatorBuilder: (context, index) => Divider(),
				itemCount: 3,
			),

		);
	}

	Widget buildSummary() {
		return SizedBox(
			height: 68,
			width: double.infinity,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("总佣金"),
						Text("100000"),
						Divider(),
					],
				),
			),
		);
	}

	Widget buildListItem() {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					buildListItemLevel1(),
					SizedBox(height: 16),
					buildListItemLevel2(),
					Divider(),
				],
			),
		);
	}

	Widget buildListItemLevel1() {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("用户", "188****8888"),
				buildListElement("层级", "一级"),
				buildListElement("注册时间", "2020.1.2 10:20:30"),
			],
		);
	}

	Widget buildListItemLevel2() {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("总挖矿", "10000"),
				buildListElement("佣金比例", "5%"),
				buildListElement("我的佣金", "10"),
			],
		);
	}

	Widget buildListElement(String label, String value) {
		return Expanded(
			flex: 1,
		  child: Column(
		  	crossAxisAlignment: CrossAxisAlignment.start,
		  	children: <Widget>[
		  		Text(label),
		  		Text(value),
		  	],
		  ),
		);
	}
}