import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/tools/common_widget_tools.dart';
import 'package:myapp/tools/colorTools.dart';
import 'package:myapp/views/orderlist_view.dart';

class CheckInView extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return CheckInViewState();
  }
}

class CheckInDayModel {
	final int index;
	final String prize;
  	CheckInDayModel(this.index, this.prize);
}

class CheckInViewState extends State<CheckInView> {
	int numberOfCheckedInDay = 7;
	double checkedInPrize = 0.03;
	final count = 30;
	int tapCount = 0;
	Map<int,String>map = {
		1:"0.01U",
		7:"0.02U",
		13:"0.03U",
		19:"0.05U",
		25:"0.08U",
		30:"0.1U"
	};
	List<CheckInDayModel> modelList;
	void setupMap() {
		modelList = List.generate(count, (index) {
			if (map[index] != null) {
				return CheckInDayModel(index, map[index]);
			}
			return CheckInDayModel(index, "");
		});
	}

	@override
  Widget build(BuildContext context) {
		setupMap();
    return Scaffold(
		appBar: CommonWidgetTools.appBarWithTitle(context, "签到有礼"),
		body: SizedBox(
			width: double.infinity,
			child: Container(
		  	padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
		  	child: Column(
		  		children: <Widget>[
		  			SizedBox(
		  				width: double.infinity,
		  			  height: 50,
		  			  child: Container(
		  			  	child: Row(
		  			  		mainAxisAlignment: MainAxisAlignment.spaceBetween,
		  			  		children: <Widget>[
		  			  			Column(
		  			  				mainAxisAlignment: MainAxisAlignment.spaceBetween,
		  			  				crossAxisAlignment: CrossAxisAlignment.start,
		  			  				children: <Widget>[
		  			  					Text("已签到 ${numberOfCheckedInDay} 天"),
		  			  					Text("已奖励 ${checkedInPrize} U 算力"),
		  			  				],
		  			  			),
		  			  			SizedBox(
		  			  				width: 200,
		  			  				height: 100,
		  			  				child: Container(
		  			  					padding: EdgeInsets.all(8),
		  			  					child: FlatButton(
		  			  						color: ColorTools.green1AAD19,
		  			  						onPressed: (){
												if (tapCount++ % 2 == 1) {
													showGetCheckPrizeDialog(context);
												} else {
													showContinueCheckPrizeDialog(context);
												}
											}, child: Text("签到",style: TextStyle(color: ColorTools.whiteFFFFFF),))
		  			  				)
		  			  			),
		  			  		],
		  			  	),
		  			  ),
		  			),
					Divider(color: ColorTools.greyA1A6B3),
					buildCheckInMainView(),
					SizedBox(
						width: double.infinity,
					  height: 100,
					  child: Container(
					  	child: Center(child: Text("签到送算力,体验挖矿的乐趣!")),
					  ),
					),
		  		],
		  	),
		  ),
		),
	);
  }

	void showGetCheckPrizeDialog(BuildContext context) {
	  showDialog(
	  	context: context,
	  	builder: (BuildContext context){
	  		return AlertDialog(
	  			title: Text("恭喜您"),
	  			content: SizedBox(
	  				width: 300,
	  			  height: 80,
	  			  child: Container(
	  			  	padding: EdgeInsets.symmetric(horizontal: 6),
	  			    child: Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
	  			    	children: <Widget>[
	  			    		Text("已签到成功!"),
	  			    		Text("获得0.01U算力,挖矿正在进行中!"),
	  			    	],
	  			    ),
	  			  ),
	  			),
	  			actions: <Widget>[
	  				FlatButton(onPressed: (){
	  					Navigator.pop(context);
	  				}, child: Text("确认")),
	  				FlatButton(onPressed: (){
	  					Navigator.pop(context);
	  					Navigator. pushReplacement(
	  						context,
	  						MaterialPageRoute(
	  							builder: (context) => OrderListView(),
	  						),
	  					);
	  				}, child: Text("查看算力")),
	  			],
	  		);
	  	}
	  );
	}

	void showContinueCheckPrizeDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (BuildContext context){
				return AlertDialog(
					title: Text("恭喜您"),
					content: SizedBox(
						width: 300,
						height: 80,
						child: Container(
							padding: EdgeInsets.symmetric(horizontal: 6),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text("已签到成功!"),
									Text("再签到5天，即可获得0.02U算力!"),
								],
							),
						),
					),
					actions: <Widget>[
						FlatButton(onPressed: (){
							Navigator.pop(context);
						}, child: Text("确认")),
					],
				);
			}
		);
	}

  Widget buildCheckInMainView() {
		return SizedBox(
			width: double.infinity,
		  height: 500,
		  child: Container(
		  	child: GridView.builder(
				itemCount: count,
				gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5,mainAxisSpacing: 5,crossAxisSpacing: 5),
				itemBuilder: (context,index) {
					bool isChecked = index <= numberOfCheckedInDay;
					Color theColor = isChecked ? ColorTools.green1AAD19:ColorTools.greyA1A6B3;
		  			return SizedBox(
		  			  child: Container(
		  				  decoration: BoxDecoration(
		  					  borderRadius: BorderRadius.circular(5.0),
		  					  border: Border.all(color: theColor, width: 1.0)
		  				  ),
		  			  	child: Column(
		  					mainAxisAlignment: MainAxisAlignment.spaceAround,
		  					crossAxisAlignment: CrossAxisAlignment.center,
		  			  		children: <Widget>[
		  			  			Text("第${index}天",style: TextStyle(color: theColor)),
		  			  			Text(modelList[index].prize,style: TextStyle(color: theColor)),
		  			  		],
		  			  	),
		  			  ),
		  			);
		  	}),
		  ),
		);
  }


}