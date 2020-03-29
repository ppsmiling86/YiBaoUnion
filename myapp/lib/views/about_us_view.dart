import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/AppData.dart';
import 'package:myapp/tools/common_widget_tools.dart';
class AboutUsView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return AboutUsViewState();
  }
}

class AboutUsViewState extends State<AboutUsView> {
	@override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar:CommonWidgetTools.appBarWithTitle(context, "关于我们"),
		body: SizedBox(
			width: double.infinity,
		  child: Container(
		  	padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
		  	child: Row(
		  		children: <Widget>[
		  			Expanded(child: Text("整个页面是以灰白以主色调，同时宣导了这个公司的品牌故事、品牌价值以及真实的数据支撑。往下滚动会看到一个明显的蓝色的CTA让用户可以更加深入的了解产品并且试用。虽然页面上并没有放置公司管理人员或者职员的照片，但整个页面简洁干净易于浏览，并不会影响用户对这个公司的影响。",style:Theme.of(context).textTheme.bodyText2))
		  		],
		  	),
		  ),
		),
		bottomNavigationBar: buildBottom(),
	);
  }

  Widget buildBottom() {
		return SizedBox(
			width: double.infinity,
			height: 120,
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
				Opacity(
					opacity: 1,
					child: Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text("Build version v1.0.0.3",style: Theme.of(context).textTheme.bodyText2),
						],
					),
				),
			]
		  ),
		);
  }
}