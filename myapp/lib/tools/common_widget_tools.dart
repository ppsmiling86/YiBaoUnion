import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/models/MyNotification.dart';
import 'package:myapp/tools/imageTools.dart';
import 'colorTools.dart';
import 'package:toast/toast.dart';
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
				style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor)),
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
				style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
		);
	}

	static Widget appBarInWechatWithBuilder(BuildContext context, String title) {
		return AppBar(
			leading: Builder(builder: (context) =>
				IconButton(
					icon: CircleAvatar(
						child: Icon(Icons.person),
					),
					onPressed: (){
						MyNotification(true).dispatch(context);
					})
			),
			centerTitle: true,
			title: Text(title,
				style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor)),
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
				style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor)),
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
				style:Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor)),
//			backgroundColor: ColorTools.bkgMainColor,
			elevation: 0.0,
			actions: actions,
		);
	}

	static Widget buildBottomButton(BuildContext context,String title,VoidCallback onTap) {
		return SizedBox(
			width: double.infinity,
			height: 72,
			child: Container(
				padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
				child: SizedBox(
					height: 40,
				  child: FlatButton(
				  	shape: StadiumBorder(),
				  	color: Theme.of(context).buttonColor,
				  	onPressed: onTap,
				  	child: Text(title,style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))
				  ),
				),
			),
		);
	}

	static void showAlertController(BuildContext context, String msg) {
		showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					content: Text(msg,style: Theme.of(context).textTheme.bodyText2),
					actions: <Widget>[
						SizedBox(
							height: 40,
						  child: FlatButton(
						  	color: Theme.of(context).buttonColor,
						  	shape: StadiumBorder(),
						  	onPressed: (){
						  	Navigator.pop(context);
						  }, child: Text("确定",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
						),
					],
				);
			}
		);
	}

	static void showAlertControllerOnTap(BuildContext context, String msg, VoidCallback onTap) {
		showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					content: Text(msg,style: Theme.of(context).textTheme.bodyText2),
					actions: <Widget>[
						SizedBox(
							height: 40,
						  child: FlatButton(
						  	color: Theme.of(context).buttonColor,
						  	shape: StadiumBorder(),
						  	onPressed: (){
						  	Navigator.pop(context);
						  	onTap();
						  }, child: Text("确定",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
						),
					],
				);
			}
		);
	}

	static void showConfirmAlertController(BuildContext context, String msg, VoidCallback onConfirm) {
		showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					content: Text(msg,style: Theme.of(context).textTheme.bodyText2),
					actions: <Widget>[
						SizedBox(
							height: 40,
						  child: OutlineButton(
						  	shape: StadiumBorder(),
						  	borderSide: BorderSide(color: Theme.of(context).buttonColor),
						  	onPressed: (){
						  	Navigator.pop(context);
						  }, child: Text("取消",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).buttonColor))),
						),
						SizedBox(
							height: 40,
						  child: FlatButton(
						  	color: Theme.of(context).buttonColor,
						  	shape: StadiumBorder(),
						  	onPressed: (){
						  	onConfirm();
						  	Navigator.pop(context);
						  }, child: Text("确定",style: Theme.of(context).textTheme.button.copyWith(color: Theme.of(context).toggleableActiveColor))),
						),
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

	static void dismissLoading(BuildContext context) {
		Navigator.pop(context);
	}

	static void showLoadingWithChild(BuildContext context,Widget child) {
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
							child: Center(child: child),
						),
					),
				);
			},
		);
	}

	static void showToastView(BuildContext context, String text) {
		Toast.show(text, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
	}

	static Widget buildEmptyListPlaceholder(BuildContext context,
		[String t = '暂无数据']) {
		var width = MediaQuery.of(context).size.width;
		var height = MediaQuery.of(context).size.height;
		return Container(
			height: height / 1.5,
			child: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Image(
							image: AssetImage(ImageTools.empty_order_list),
							width: 72,
							height: 88),
						SizedBox(height: 4),
						Text(t,
							style: Theme.of(context).textTheme.bodyText2),
					],
				)),
		);
	}

	static Widget buildCopyright(BuildContext context) {
		return SizedBox(
			width: double.infinity,
			height: 40,
			child: Column(
				children: [
					Container(
						child: Center(
							child: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Text(AppData().getCopyright(),style: Theme.of(context).textTheme.bodyText2),
								],
							),
						),
					),
//				Opacity(
//					opacity: 1,
//					child: Row(
//						mainAxisAlignment: MainAxisAlignment.center,
//						children: <Widget>[
//							Text("Build version v1.0.0.3",style: Theme.of(context).textTheme.bodyText2),
//						],
//					),
//				),
				]
			),
		);
	}
}