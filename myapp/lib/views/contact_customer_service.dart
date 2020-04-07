import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/callAndMessageService.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clippy/browser.dart' as clippy;
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
		  			buildListItem("官方客服电话", "18681373320", "","拨打电话",(){
		  				CallsAndMessagesService().call("18681373320");
		  			}),
		  			SizedBox(height: 30),
		  			Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Expanded(
								flex: 1,
								child: buildListItem("客服微信", "18681373320", ImageTools.CustomerServiceWechatQRCode,"复制并打开微信",(){
									clippy.write("18681373320");
									CallsAndMessagesService().sendWechat("18681373320");
								})),
						],
					)
		  		],
		  	),
		  ),
		),
	);
  }

  Widget buildListItem(String title, String value, String image,String lickableString, Function onTap) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: <Widget>[
				Text(title,style: Theme.of(context).textTheme.subtitle1),
				SizedBox(height: 10),
				Row(
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
						Text(value,style: Theme.of(context).textTheme.headline6),
						SizedBox(width: 5),
						GestureDetector(
							onTap: onTap,
							child: Text(lickableString,style: Theme.of(context).textTheme.subtitle1.copyWith(decoration: TextDecoration.underline))),
					],
				),
				SizedBox(height: 10),
				image.isNotEmpty ? buildImage(image) : Container()
			],
		);
  }

  Widget buildImage(String img) {
		return SizedBox(
			width: 200,
		  height: 200,
		  child: Container(
		  	child: Image(
				fit: BoxFit.fill,
				image: AssetImage(img),width: 200,height: 200),
		  ),
		);
  }
}