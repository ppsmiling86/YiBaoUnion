import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
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
		appBar: AppBar(
			leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
				Navigator.of(context).pop();
			}),
			title: Text("联系客服"),
			centerTitle: true,
		),
		body: SizedBox(
			width: double.infinity,
		  child: Container(
			  padding: EdgeInsets.symmetric(horizontal: 32,vertical: 32),
		  	child: Column(
		  		children: <Widget>[
		  			buildListItem("官方客服电话", "1838838888", ""),
		  			SizedBox(height: 30),
		  			Row(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
							Expanded(
								flex: 1,
								child: buildListItem("客服QQ", "999999999", ImageTools.placeholder_qrcode)),
							Expanded(
								flex: 1,
								child: buildListItem("客服微信", "999999999", ImageTools.placeholder_qrcode)),
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
				Text(title),
				Text(value),
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