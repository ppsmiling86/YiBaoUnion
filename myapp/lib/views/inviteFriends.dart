import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'package:myapp/tools/colorTools.dart';

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
		appBar: AppBar(
			leading: IconButton(icon: Icon(Icons.arrow_left), onPressed: (){
				Navigator.of(context).pop();
			}),
			title: Text("邀请好友"),
			centerTitle: true,
		),

body: Container(
  child:   Center(
    child: SizedBox(
    	height: 200,
    	width: double.infinity,
    	child: Column(
    		children: <Widget>[
    			Image(image: AssetImage(ImageTools.placeholder_qrcode),width: 100,height: 100),
    			SizedBox(height: 50),
    			Text("邀请好友可额外获得好友挖矿所产积分20%的奖励"),
    		],
    	),
    ),
  ),
),
//		body: ListView(
//			children: <Widget>[
//				SizedBox(height: 50),
//				SizedBox(
//					width: 100,
//					height: 100,
//					child: Image(
//						fit: BoxFit.fill,
//						image: AssetImage(ImageTools.placeholder_qrcode),width: 100,height: 100),
//				),
//				SizedBox(height: 50),
//				Text("邀请好友可额外获得好友挖矿所产积分20%的奖励"),
//			],
//		),
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
		  			    	child: Text("我的佣金",style: TextStyle(color: ColorTools.green1AAD19)),
		  			    	onPressed: (){

		  			    }),
		  			  ),
		  			),
		  			Expanded(
		  				flex: 1,
		  				child: Container(
							padding: EdgeInsets.only(left: 8),
		  				  child: FlatButton(
		  				  	color: ColorTools.green1AAD19,
		  				  	onPressed: (){}, child: Text("复制邀请",style: TextStyle(color: Colors.white),)),
		  				)
		  			),
		  		],
		  	),
		  ),
		);
  }
}