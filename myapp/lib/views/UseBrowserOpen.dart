import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/imageTools.dart';
import 'home_view.dart';
import 'package:ant_icons/ant_icons.dart';
import 'package:myapp/models/MyNotification.dart';
import 'dart:math' as math;
class UseBrowserOpenView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return UseBrowserOpenViewState();
  }
}

class UseBrowserOpenViewState extends State <UseBrowserOpenView> {
	bool showMask = false;
	@override
  Widget build(BuildContext context) {
		List<Widget>children = [Container(
			child: HomeView(isInWechat: true),
		)];
		if (showMask) {
			children.addAll(this.coverWidget());
		}
     return Scaffold(
		body: SizedBox(
			width: double.infinity,
		  height: double.infinity,
		  child: NotificationListener<MyNotification>(
			  onNotification: (notification) {
				  setState(() {
					  showMask = true;
				  });
				  return true;
			  },
		    child: Stack(
		    	children:children,
		    ),
		  ),
		),
	 );
  }


  List<Widget> coverWidget() {
		return [Container(
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
										child: Text("1",style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor))),
									SizedBox(width: 10),
									Text("点击右上角的",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).toggleableActiveColor)),
									Icon(Icons.more_horiz,color: Colors.white),
									Text("按钮",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).toggleableActiveColor)),
									SizedBox(width: 53),
								],
							),
							Row(
								mainAxisAlignment: MainAxisAlignment.end,
								children: <Widget>[
									CircleAvatar(
										backgroundColor: Colors.deepOrange,
										child: Text("2",style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).toggleableActiveColor))),
									SizedBox(width: 10),
									Text("选择",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).toggleableActiveColor)),
									FlatButton.icon(
										shape: StadiumBorder(),
										onPressed: (){}, icon: Icon(Icons.language,color: Colors.white), label: Text("在浏览器中打开",style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).toggleableActiveColor))),
								],
							),
						],
					),
				),
			)];
  }
}