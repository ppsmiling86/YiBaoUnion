import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'home_view.dart';
import 'package:ant_icons/ant_icons.dart';
import 'dart:math' as math;
class UseBrowserOpenView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return UseBrowserOpenViewState();
  }
}

class UseBrowserOpenViewState extends State <UseBrowserOpenView> {
	@override
  Widget build(BuildContext context) {
     return Scaffold(
		body: SizedBox(
			width: double.infinity,
		  height: double.infinity,
		  child: Stack(
		  	children: <Widget>[
		  		Container(
					child: HomeView(),
				),
		  		Container(
						decoration: BoxDecoration(
							border: Border.all(width: 1 ,color: Colors.transparent), //color is transparent so that it does not blend with the actual color specified
							color: Color.fromRGBO(0, 0, 0, 0.5) // Specifies the background color and the opacity
						),
		  		),
		  		SizedBox(
		  			width: double.infinity,
		  		  height: 250,
		  		  child: Container(
		  		  	child: Column(
		  		  		children: <Widget>[
								Row(
									mainAxisAlignment: MainAxisAlignment.end,
									children: <Widget>[
										Expanded(child: Container()),
										Transform.rotate(
											angle: 45 * math.pi / 180,
											child: Image(image: AssetImage(ImageTools.arc_arrow,),width: 100, height: 92),
										),
									],
								),
		  		  			Row(
								mainAxisAlignment: MainAxisAlignment.end,
		  		  				children: <Widget>[
									CircleAvatar(
										backgroundColor: Colors.deepOrange,
										child: Text("1",style: TextStyle(fontSize: 24,color: Colors.white))),
		  		  					SizedBox(width: 10),
		  		  					Text("点击右上角的",style: TextStyle(fontSize: 16,color: Colors.white)),
		  		  					Icon(Icons.more_horiz,size: 30,color: Colors.white),
		  		  					Text("按钮",style: TextStyle(fontSize: 16,color: Colors.white)),
									SizedBox(width: 45),
		  		  				],
		  		  			),
		  		  			Row(
								mainAxisAlignment: MainAxisAlignment.end,
		  		  				children: <Widget>[
									CircleAvatar(
										backgroundColor: Colors.deepOrange,
										child: Text("2",style: TextStyle(fontSize: 24,color: Colors.white))),
									SizedBox(width: 10),
		  		  					Text("选择",style: TextStyle(fontSize: 16,color: Colors.white)),
		  		  					FlatButton.icon(onPressed: (){}, icon: Icon(Icons.language,size:30,color: Colors.white), label: Text("在浏览器中打开",style: TextStyle(fontSize: 16,color: Colors.white))),
		  		  				],
		  		  			),
		  		  		],
		  		  	),
		  		  ),
		  		)
		  	],
		  ),
		),
	 );
  }
}