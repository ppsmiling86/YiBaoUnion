import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/downlinkUserBloc.dart';
import 'package:myapp/models/Response.dart';
class MyFriendsView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return MyFriendsViewState();
	}
}

class MyFriendsViewState extends State<MyFriendsView> {
	final bloc = DownlinkUserBloc();
	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.downlinkUser();
  }
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "我的好友"),
			body: buildStreamBuilderView(),
		);
	}

	Widget buildFriendsList(DownlinkUserResponse response) {
		return ListView.separated(
			itemBuilder: (contest,index) {
				if (index == 0) {
					return buildSummary();
				} else {
					return buildListItem(response.data[index]);
				}
			},
			separatorBuilder: (context, index) => Divider(),
			itemCount: response.data.length,
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

	Widget buildListItem(DownlinkUserEntity downlinkUserEntity) {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					buildListItemLevel1(downlinkUserEntity),
					SizedBox(height: 16),
					buildListItemLevel2(downlinkUserEntity),
					Divider(),
				],
			),
		);
	}

	Widget buildListItemLevel1(DownlinkUserEntity downlinkUserEntity) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("用户", "${downlinkUserEntity.uid}"),
				buildListElement("层级", "${downlinkUserEntity.uid}"),
				buildListElement("注册时间", "${downlinkUserEntity.uid}"),
			],
		);
	}

	Widget buildListItemLevel2(DownlinkUserEntity downlinkUserEntity) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("总挖矿", "${downlinkUserEntity.balance}"),
				buildListElement("佣金比例", "${downlinkUserEntity.balance * 100}%"),
				buildListElement("我的佣金", "${downlinkUserEntity.balance}"),
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

	StreamBuilder buildStreamBuilderView() {
		return StreamBuilder<DownlinkUserResponse>(
			stream: bloc.subject.stream,
			builder: (context, AsyncSnapshot<DownlinkUserResponse> snapshot) {
				print(snapshot);
				if (snapshot.hasData) {
					return buildFriendsList(snapshot.data);
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
}