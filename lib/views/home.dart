import 'package:flutter/material.dart';
import '../utils/api.dart' as api;
import './homeList.dart';
import '../utils/utils.dart';
import '../utils/constant.dart';

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
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Fighter)),
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Tank)),
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Mage)),
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Assassin)),
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Support)),
          HomeList(data: Utils.filterHeroByTag(heroList, Tags.Marksman)),
        ],
      ),
    );
  }
}
