import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrizeRuleView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		// TODO: implement createState
		return PrizeRuleViewState();
	}
}

class PrizeRuleViewState extends State<PrizeRuleView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
					Navigator.of(context).pop();
				}),
				title: Text( "佣金规则"),
				centerTitle: true,
			),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Text("邀请好友获得共创积分奖励"),
						SizedBox(height: 30),
						Text("一级好友: 额外奖励好友挖矿所得总积分 * 5% 。"),
						Text("二级好友: 额外奖励好友挖矿所得总积分 * 3% 。"),
						SizedBox(height: 30),
						Text("奖励发放时间与好友所购买算力的清算时间同步，为每日早晨10点整。"),
					],
				),
			),
		);
	}
}