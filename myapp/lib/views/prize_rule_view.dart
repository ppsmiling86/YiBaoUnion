import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class PrizeRuleView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return PrizeRuleViewState();
	}
}

class PrizeRuleViewState extends State<PrizeRuleView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitle(context, "佣金规则"),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("邀请好友获得共创积分奖励",style: Theme.of(context).textTheme.bodyText2),
						SizedBox(height: 30),
						Text("一级好友: 额外奖励好友挖矿所得总积分 * 5% 。",style: Theme.of(context).textTheme.bodyText2),
						Text("二级好友: 额外奖励好友挖矿所得总积分 * 3% 。",style: Theme.of(context).textTheme.bodyText2),
						SizedBox(height: 30),
						Text("奖励发放时间与好友所购买算力的清算时间同步，为每日早晨10点整。",style: Theme.of(context).textTheme.bodyText2),
					],
				),
			),
		);
	}
}