import 'package:flutter/material.dart';
import '../utils/api.dart' as api;

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  // 定义一个TabController
  TabController _tabController;
  List<dynamic> heroList = [];

  @override
  void initState() {
    super.initState();
    // 添加控制器
    _tabController = TabController(vsync: this, initialIndex: 0, length: 6);
    init();
  }

  init() async {
    Map res = await api.getHeroList();
    setState(() {
      heroList = res.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: <Widget>[
            Tab(text: '战士',),
            Tab(text: '坦克',),
            Tab(text: '法师',),
            Tab(text: '刺客',),
            Tab(text: '辅助',),
            Tab(text: '射手',),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Text('战士'),
          Text('坦克'),
          Text('法师'),
          Text('刺客'),
          Text('辅助'),
          Text('射手'),
        ],
      ),
    );
  }
}
