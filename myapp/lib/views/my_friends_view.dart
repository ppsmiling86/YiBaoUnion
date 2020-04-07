import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/models/downlinkUserBloc.dart';
import 'package:myapp/models/Response.dart';
import 'package:myapp/tools/dateTools.dart';
class MyFriendsView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return MyFriendsViewState();
	}
}

class MyFriendsViewState extends State<MyFriendsView> {
	final bloc = DownlinkUserBloc();
	@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.dispose();
  }
	
	@override
	Widget build(BuildContext context) {
		bloc.downlinkUser();
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "我的好友"),
			body: buildStreamBuilderView(),
		);
	}

	Widget buildFriendsList(DownlinkUserResponse response) {
		List<Widget>container = [];
		container.add(SizedBox(height: 6));
		container.add(buildSummary(response.data));
		container.add(Divider(thickness: 1));
		if(response.data.records.length > 0) {
			response.data.records.forEach((f) {
				container.add(buildListItem(f));
				container.add(Divider(thickness: 1));
			});
		} else {
			container.add(CommonWidgetTools.buildEmptyListPlaceholder(context));
		}
		return ListView(
			children: container,
		);
	}

	Widget buildSummary(DownlinkUserPackage downlinkUserPackage) {
		return SizedBox(
			height: 82,
			width: double.infinity,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("我的总佣金",style: Theme.of(context).textTheme.subtitle1),
						SizedBox(height: 10),
						Text("${downlinkUserPackage.total_received_commission}",style: Theme.of(context).textTheme.subtitle1),
					],
				),
			),
		);
	}

	Widget buildListItem(DownlinkUserEntity downlinkUserEntity) {
		return Container(
			padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: <Widget>[
					buildListItemLevel1(downlinkUserEntity),
					SizedBox(height: 10),
					buildListItemLevel2(downlinkUserEntity),
				],
			),
		);
	}

	Widget buildListItemLevel1(DownlinkUserEntity downlinkUserEntity) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("用户", "${downlinkUserEntity.uid}",5),
				buildListElement("层级", "${downlinkUserEntity.level}级",3),
				buildListElement("注册日期", "${DateTools.ConvertDateToYearMonthDay(downlinkUserEntity.created_at)}",3,CrossAxisAlignment.end),
			],
		);
	}

	Widget buildListItemLevel2(DownlinkUserEntity downlinkUserEntity) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("总挖矿", "${downlinkUserEntity.total_buy_score}",5),
				buildListElement("佣金比例", "${downlinkUserEntity.ratio}",3),
				buildListElement("我的佣金", "${downlinkUserEntity.commission}",3,CrossAxisAlignment.end),
			],
		);
	}

	Widget buildListElement(String label, String value,int flex,[CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start]) {
		return Expanded(
			flex: flex,
		  child: Column(
		  	crossAxisAlignment: crossAxisAlignment,
		  	children: <Widget>[
		  		Text(label,style: Theme.of(context).textTheme.caption),
		  		SizedBox(height: 5),
		  		Text(value,style: Theme.of(context).textTheme.bodyText1),
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