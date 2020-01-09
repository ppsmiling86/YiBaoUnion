import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ant_icons/ant_icons.dart';
import 'colorTools.dart';
class CommonWidgetTools {
	static Widget appBarWithTitleLeading(
		BuildContext context, String title, VoidCallback leftOnTap) {
		return AppBar(
			leading: IconButton(
				icon: Icon(AntIcons.left_outline),
				onPressed: leftOnTap,
			),
			centerTitle: true,
			title: Text(title,
				style: TextStyle(
					fontWeight: FontWeight.w500,
					fontSize: 18,
					color: ColorTools.whiteFFFFFF)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
		);
	}

	static Widget appBarWithBuilder(BuildContext context, String title) {
		return AppBar(
			leading: Builder(builder: (context) =>
				IconButton(
					icon: CircleAvatar(
						child: Icon(Icons.person),
					),
					onPressed: (){
						Scaffold.of(context).openDrawer();
					})
			),
			centerTitle: true,
			title: Text(title,
				style: TextStyle(
					fontWeight: FontWeight.w500,
					fontSize: 18,
					color: ColorTools.whiteFFFFFF)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
		);
	}

	static Widget appBarWithTitle(
		BuildContext context, String title) {
		return AppBar(
			leading: IconButton(
				icon: Icon(AntIcons.left_outline),
				onPressed: (){
					Navigator.of(context).pop();
				},
			),
			centerTitle: true,
			title: Text(title,
				style: TextStyle(
					fontWeight: FontWeight.w500,
					fontSize: 18,
					color: ColorTools.whiteFFFFFF)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
		);
	}

	static Widget appBarWithTitleActions(
		BuildContext context, String title,List<Widget>actions) {
		return AppBar(
			leading: IconButton(
				icon: Icon(AntIcons.left_outline),
				onPressed: (){
					Navigator.of(context).pop();
				},
			),
			centerTitle: true,
			title: Text(title,
				style: TextStyle(
					fontWeight: FontWeight.w500,
					fontSize: 18,
					color: ColorTools.whiteFFFFFF)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
			actions: actions,
		);
	}

	static Widget buildBottomButton(String title,VoidCallback onTap) {
		return SizedBox(
			width: double.infinity,
			height: 72,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: FlatButton(
					color: ColorTools.green1AAD19,
					onPressed: onTap,
					child: Text(title,style: TextStyle(color: Colors.white))
				),
			),
		);
	}

	static void showAlertController(BuildContext context, String msg) {
		showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					content: Text(msg),
					actions: <Widget>[
						FlatButton(onPressed: (){
							Navigator.pop(context);
						}, child: Text("确定")),
					],
				);
			}
		);
	}

	static void showLoading(BuildContext context) {
		showDialog(
			context: context,
			barrierDismissible: false,
			builder: (BuildContext context) {
				return Dialog(
					child:
					SizedBox(
						width: 100,
						height: 100,
						child: Container(
							child: Center(child: CircularProgressIndicator()),
						),
					),
				);
			},
		);
	}
}