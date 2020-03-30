import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/callAndMessageService.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class ContactCustomerServiceView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return ContactCustomerServiceViewState();
  }
}

class ContactCustomerServiceViewState extends State<ContactCustomerServiceView> {
	@override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: CommonWidgetTools.appBarWithTitle(context, "联系客服"),
		body: SizedBox(
			width: double.infinity,
		  child: Container(
			  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 32),
		  	child: Column(
		  		children: <Widget>[
		  			GestureDetector(
						onTap: (){
							CallsAndMessagesService().call("1838838888");
						},
						child: buildListItem("官方客服电话", "1838838888", "")),
		  			SizedBox(height: 30),
		  			Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Expanded(
								flex: 1,
								child: GestureDetector(
									onTap: (){
										CallsAndMessagesService().sendQQ("999999999");
									},
									child: buildListItem("客服QQ", "999999999", ImageTools.placeholder_qrcode))),
							Expanded(
								flex: 1,
								child: GestureDetector(
									onTap: (){
										CallsAndMessagesService().sendWechat("999999999");
									},
									child: buildListItem("客服微信", "999999999", ImageTools.placeholder_qrcode))),
						],
					)
		  		],
		  	),
		  ),
		),
	);
  }

  Widget buildListItem(String title, String value, String image) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Text(title,style: Theme.of(context).textTheme.subtitle1),
				Text(value,style: Theme.of(context).textTheme.bodyText2.copyWith(decoration: TextDecoration.underline)),
				image.isNotEmpty ? buildImage(image) : Container()
			],
		);
  }

  Widget buildImage(String img) {
		return SizedBox(
			width: 100,
		  height: 100,
		  child: Container(
		  	child: Image(
				fit: BoxFit.fill,
				image: AssetImage(img),width: 100,height: 100),
		  ),
		);
  }
}