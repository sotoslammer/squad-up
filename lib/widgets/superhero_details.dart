import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/attack.dart';
import 'package:squadup/models/attack_type.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/util.dart';
import 'package:squadup/widgets/attacks.dart';
import 'package:squadup/widgets/icons.dart';
import 'package:squadup/widgets/stat_bar.dart';

class SuperheroDetails extends StatefulWidget {
  final Superhero superhero;

  const SuperheroDetails({Key? key, required this.superhero}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperheroDetailsState();
}

class _SuperheroDetailsState extends State<SuperheroDetails>
    with SingleTickerProviderStateMixin {
  bool viewHealthy = true;
  final tabs = [Tab(text: 'ATTACKS'), Tab(text: 'SUPERPOWERS')];

  late TabController _tabController =
      TabController(length: tabs.length, vsync: this);

  void setViewHealthyStatline(bool value) {
    setState(() {
      viewHealthy = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              StatBar(
                superhero: widget.superhero,
                viewHealthy: viewHealthy,
                onViewHealthyChange: setViewHealthyStatline,
                tabBar: TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  tabs: tabs,
                  controller: _tabController,
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(child: buildBody()),
          )),
    );
  }

  Widget buildBody() {
    var selectedTab = _tabController.index;
    var panels;
    if (selectedTab == 0) {
      var attacks = widget.superhero.attacksBySuperheroId?.nodes ?? [];
      if (viewHealthy) {
        attacks = attacks.where((a) => a.healthy == true).toList();
      } else {
        attacks = attacks.where((a) => a.injured == true).toList();
      }
      return Attacks(attacks: attacks);
    } else {
      var superpowers = widget.superhero.superPowersBySuperheroId?.nodes ?? [];
      if (viewHealthy) {
        superpowers = superpowers.where((s) => s.healthy == true).toList();
      } else {
        superpowers = superpowers.where((s) => s.injured == true).toList();
      }
      panels = superpowers
          .map((s) => ExpansionPanel(
              headerBuilder: (context, isExpanded) =>
                  ListTile(title: Text(s.name ?? '')),
              body: ListTile(title: Text(s.effect ?? ''))))
          .toList();
    }

    return ExpansionPanelList(
      children: panels,
      dividerColor: Colors.white30,
    );
  }
}
