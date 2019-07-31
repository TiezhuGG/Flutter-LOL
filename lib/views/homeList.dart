import 'package:flutter/material.dart';
import 'package:flutter_lol/models/heroSimple.dart';
import '../widgets/hero/heroItem.dart';

class HomeList extends StatefulWidget {
  final List data;
  HomeList({Key key, this.data}) : super(key: key);

  _HomeListState createState() => _HomeListState();
}


class _HomeListState extends State<HomeList> with AutomaticKeepAliveClientMixin {
  // 切换后页面保持状态(防止页面重载)
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
       child: ListView.builder(
         itemCount: 10,
         itemBuilder: (BuildContext context, int index) {
           return HeroItem(data: HeroSimple.fromJson(widget.data[index]));
         },
       ),
    );
  }
}