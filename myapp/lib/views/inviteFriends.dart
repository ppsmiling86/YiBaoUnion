import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/colorTools.dart';
import 'my_friends_view.dart';
import 'package:clippy/browser.dart' as clippy;
import 'prize_rule_view.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class InviteFriendsView extends StatefulWidget {
	@override
	State<StatefulWidget> createState() {
		return InviteFriendsViewState();
	}
}

class InviteFriendsViewState extends State<InviteFriendsView> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: CommonWidgetTools.appBarWithTitleActions(context, "邀请好友", [
				Center(
				child: SizedBox(
					width: 120,
					height: 40,
					child: Container(
						padding: EdgeInsets.symmetric(horizontal: 16),
						child: OutlineButton(onPressed: (){
							Navigator.push(context, MaterialPageRoute(builder: (context) => PrizeRuleView())
							);
						},
							child: Text("佣金规则"),),
					),
				),
			),
			]),

			body: Container(
				child:   Center(
					child: SizedBox(
						height: 200,
						width: double.infinity,
						child: Column(
							children: <Widget>[
								Image(image: AssetImage(ImageTools.placeholder_qrcode),width: 100,height: 100),
								SizedBox(height: 50),
								Text("邀请好友赚佣金"),
							],
						),
					),
				),
			),
			bottomNavigationBar: buildBottomButtons(),
		);
	}

	Widget buildBottomButtons() {
		return SizedBox(
			width: double.infinity,
			height: 100,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						Expanded(
							flex: 1,
							child: Container(
								padding: EdgeInsets.only(right: 8),
								child: OutlineButton(
									borderSide: BorderSide(
										color: ColorTools.green1AAD19,
										style: BorderStyle.solid,
										width: 2,
									),
									child: Text("我的团队",style: TextStyle(color: ColorTools.green1AAD19)),
									onPressed: (){
										Navigator.push(
											context,
											MaterialPageRoute(builder: (context) => MyFriendsView()),
										);
									}),
							),
						),
						Expanded(
							flex: 1,
							child: Container(
								padding: EdgeInsets.only(left: 8),
								child: FlatButton(
									color: ColorTools.green1AAD19,
									onPressed: () {
										clippy.write('www.baiducom');
										CommonWidgetTools.showToastView(context, "复制成功");
									}, child: Text("复制邀请链接",style: TextStyle(color: Colors.white),)),
							)
						),
					],
				),
			),
		);
	}

}