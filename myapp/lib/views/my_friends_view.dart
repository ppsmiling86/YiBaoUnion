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
		container.add(buildSummary(response.data));

		if(response.data.records.length > 0) {
			response.data.records.forEach((f) {
				container.add(Divider(thickness: 1));
				container.add(buildListItem(f));
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
			height: 70,
			width: double.infinity,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("总佣金",style: Theme.of(context).textTheme.subtitle1),
						Text("${downlinkUserPackage.total_received_commission}"),
						Divider(thickness: 1),
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
					Divider(thickness: 1),
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
				buildListElement("层级", "${downlinkUserEntity.level}级"),
				buildListElement("注册时间", "${DateTools.ConvertDateToString(downlinkUserEntity.created_at)}"),
			],
		);
	}

	Widget buildListItemLevel2(DownlinkUserEntity downlinkUserEntity) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				buildListElement("总挖矿", "${downlinkUserEntity.total_buy_score}"),
				buildListElement("佣金比例", "${downlinkUserEntity.ratio}"),
				buildListElement("我的佣金", "${downlinkUserEntity.commission}"),
			],
		);
	}

	Widget buildListElement(String label, String value) {
		return Expanded(
			flex: 1,
		  child: Column(
		  	crossAxisAlignment: CrossAxisAlignment.start,
		  	children: <Widget>[
		  		Text(label,style: Theme.of(context).textTheme.subtitle1),
		  		Text(value,style: Theme.of(context).textTheme.bodyText2),
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