import 'package:flutter/material.dart';
import 'package:flutter_lol/models/heroSimple.dart';
import '../models/heroDetail.dart';
import '../utils/api.dart' as api;
import '../widgets/detail/detailItem.dart';
import '../widgets/detail/skin.dart';
import '../widgets/detail/info.dart';
import '../utils/utils.dart';

class HeroDetail extends StatefulWidget {
  final HeroSimple heroSimple;
  HeroDetail({Key key, this.heroSimple}) : super(key: key);

  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  HeroDetailModel _heroData; // hero数据
  bool _loading = false; // 加载状态
  String _version = ''; // 国服版本
  String _updated = ''; // 文档跟新时间

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {
      _loading = true;
    });
    Map res = await api.getHeroDetail(widget.heroSimple.id);
    var data = res['data'];
    String version = res['version'];
    String updated = res['updated'];
    print(version);
    setState(() {
      _heroData = HeroDetailModel.fromJson(data);
      _version = version;
      _updated = updated;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.heroSimple.name), elevation: 0),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailItem(
                    title: '皮肤',
                    child: Skins(imgList: _heroData.skins),
                  ),
                  DetailItem(
                    title: '类型',
                    child: Row(
                        children: _heroData.tags
                            .map((tag) => Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    child: Text(
                                      Utils.heroTagsMap(tag),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            .toList()),
                  ),
                  DetailItem(
                    title: '属性',
                    child: HeroInfo(data: _heroData.info),
                  ),
                  DetailItem(
                    title: '使用技巧',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _heroData.allytips
                          .map((tip) => Column(
                                children: <Widget>[
                                  Text(tip),
                                  SizedBox(height: 5)
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  DetailItem(
                    title: '对抗技巧',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _heroData.enemytips
                          .map((tip) => Column(
                                children: <Widget>[
                                  Text(tip),
                                  SizedBox(height: 5)
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  DetailItem(
                    title: '背景故事',
                    child: Text(_heroData.lore),
                  ),
                  DetailItem(
                    title: '国服版本',
                    child: Text(_version),
                  ),
                  DetailItem(
                    title: '更新时间',
                    child: Text(_updated),
                  )
                ],
              ),
            ),
    );
  }
}
