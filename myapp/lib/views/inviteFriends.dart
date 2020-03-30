import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/colorTools.dart';
import 'my_friends_view.dart';
import 'package:clippy/browser.dart' as clippy;
import 'prize_rule_view.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:myapp/models/AppData.dart';

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
						child: OutlineButton(
							shape: StadiumBorder(),
							onPressed: (){
							Navigator.push(context, MaterialPageRoute(builder: (context) => PrizeRuleView())
							);
						},
							child: Text("佣金规则",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
					),
				),
			),
			]),

			body: Container(
				child:   Center(
					child: SizedBox(
						height: 400,
						width: double.infinity,
						child: Column(
							children: <Widget>[
								buildInviteCodeQrImage(AppData().loginUser().userProfileEntity.invite_url),
								SizedBox(height: 50),
								Text("邀请好友赚佣金",style: Theme.of(context).textTheme.bodyText2),
							],
						),
					),
				),
			),
			bottomNavigationBar: buildBottomButtons(),
		);
	}

	Widget buildInviteCodeQrImage(String inviteCode) {
		return QrImage(
			data: inviteCode,
			version: QrVersions.auto,
			size: 200.0,
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
								child: SizedBox(
									height: 40,
								  child: OutlineButton(
								  	shape: StadiumBorder(),
									  borderSide: BorderSide(color: Theme.of(context).buttonColor),
								  	child: Text("我的团队",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).buttonColor)),
								  	onPressed: (){
								  		Navigator.push(
								  			context,
								  			MaterialPageRoute(builder: (context) => MyFriendsView()),
								  		);
								  	}),
								),
							),
						),
						Expanded(
							flex: 1,
							child: Container(
								padding: EdgeInsets.only(left: 8),
								child: SizedBox(
									height: 40,
								  child: FlatButton(
								  	shape: StadiumBorder(),
								  	color: Theme.of(context).buttonColor,
								  	onPressed: () {
								  		clippy.write(AppData().loginUser().userProfileEntity.invite_url);
								  		CommonWidgetTools.showToastView(context, "复制成功");
								  	}, child: Text("复制邀请链接",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))
							),
								),
							)
						),
					],
				),
			),
		);
	}

}