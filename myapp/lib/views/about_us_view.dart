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
		  			Expanded(child: Text("【共创算力工会】：\n\n        由节点建设及运维方【龙门算力】倡议发起，联合成都、杭州、武汉、长沙、广东等国家骨干网超级节点成立【共创算力工会】，旨在为民生区块链项目提供稳定、高效、安全的区块链算力基础设施。\n\n【算力短租】：\n\n    	为了让更多的社群成员参与到共创医保项目，经算力工会常务理事会商议，将其下7个超级节点挖矿收益作为抵押，算力切割作为技术服务短租标的：\n	● 1个超级节点划分为1000份(1000Units,简称1000U)；\n	● 以50人民币/U的价格短租，按天结算；\n	● 7个超级节点总计7000U；\n	● 社群会员可以通过算力短租接口认购；\n",style:Theme.of(context).textTheme.bodyText2))
		  		],
		  	),
		  ),
		),
		bottomNavigationBar: CommonWidgetTools.buildCopyright(context),
	);
  }
}