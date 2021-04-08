import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squadup/models/attack.dart';
import 'package:squadup/models/attack_type.dart';
import 'package:squadup/models/super_power.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/util.dart';
import 'package:squadup/widgets/attacks.dart';
import 'package:squadup/widgets/icons.dart';
import 'package:squadup/widgets/stat_bar.dart';
import 'package:squadup/widgets/superpowers.dart';

class SuperheroDetails extends StatefulWidget {
  final Superhero superhero;

  const SuperheroDetails({Key? key, required this.superhero}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuperheroDetailsState();
}

class _SuperheroDetailsState extends State<SuperheroDetails>
    with SingleTickerProviderStateMixin {
  bool viewHealthy = true;
  late List<SuperPower> superpowers = widget.superhero.healthySuperpowers;
  late List<Attack> attacks = widget.superhero.healthyAttacks;
  final tabs = [Tab(text: 'ATTACKS'), Tab(text: 'SUPERPOWERS')];

  late TabController _tabController =
      TabController(length: tabs.length, vsync: this);

  void setViewHealthyStatline(bool value) {
    setState(() {
      viewHealthy = value;
      if (value) {
        superpowers = widget.superhero.healthySuperpowers;
        attacks = widget.superhero.healthyAttacks;
      } else {
        superpowers = widget.superhero.injuredSuperpowers;
        attacks = widget.superhero.injuredAttacks;
      }
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
    if (selectedTab == 0) {
      return Attacks(attacks: attacks);
    } else {
      return Superpowers(superpowers: superpowers);
    }
  }
}
