import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/speed.dart';
import 'package:squadup/models/superhero.dart';
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
          body: buildBody()),
    );
  }

  Widget buildBody() {
    var selectedTab = _tabController.index;
    int count;
    var builder;
    if (selectedTab == 0) {
      var attacks = widget.superhero.attacksBySuperheroId?.nodes ?? [];
      count = attacks.length;
      builder = (BuildContext context, int index) {
        var attack = attacks[index];
        return Card(child: ListTile(title: Text(attack.name ?? '')));
      };
    } else {
      var superpowers = widget.superhero.superPowersBySuperheroId?.nodes ?? [];
      count = superpowers.length;
      builder = (BuildContext context, int index) {
        var superpower = superpowers[index];
        return Card(child: ListTile(title: Text(superpower.name ?? '')));
      };
    }

    return ListView.builder(
      itemCount: count,
      itemBuilder: builder,
    );
  }
}
