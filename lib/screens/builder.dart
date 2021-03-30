import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/models/roster.dart';

import '../get_it.dart';

class BuilderScreen extends StatelessWidget {
  final builderBloc = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    var roster = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
        create: (BuildContext context) => builderBloc..add(SetRoster(roster)),
        child: Builder(bloc: builderBloc));
  }
}

class Builder extends StatefulWidget {
  final RosterBuilderBloc bloc;

  Builder({this.bloc});

  @override
  State<StatefulWidget> createState() => BuilderState();
}

class BuilderState extends State<Builder> {
  final nameController = TextEditingController(text: '');

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RosterBuilderBloc, RosterBuilderState>(
        builder: (context, state) {
      Widget body;
      if (state is BuildingRosterInit) {
        body = Center(child: CircularProgressIndicator());
      } else if (state is BuildingRoster) {
        body = _Builder(roster: state.roster);
      }

      return SafeArea(
          child: Scaffold(appBar: AppBar(title: Text("Builder")), body: body));
    });
  }
}

class _Builder extends StatefulWidget {
  final Roster roster;

  const _Builder({@required this.roster}) : super();

  @override
  State<StatefulWidget> createState() => _BuilderState(roster);
}

class _BuilderState extends State<_Builder> with SingleTickerProviderStateMixin {
  final tabs = [
    Tab(text: 'CHARACTERS'),
    Tab(text: 'TACTICS'),
    Tab(text: 'CRISIS'),
  ];

  TabController _tabController;
  List cards = [];
  final nameController = TextEditingController(text: '');

  final Roster roster;
  _BuilderState(this.roster);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
    cards = roster.superHeroes;
  }

  @override
  void dispose() {
    nameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    final selections = [
      roster.superHeroes,
      roster.tacticCards,
      roster.crisisCards
    ];
    if (_tabController.indexIsChanging) {
      setState(() {
        cards = selections[_tabController.index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "eg. Avengers, Brotherhood",
                            labelText: "Name"),
                      )),
                  Padding(
                      padding: EdgeInsets.all(16.0), child: Text('Affiliation'))
                ],
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            bottom: TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              tabs: tabs,
              controller: _tabController,
            ),
          )
        ];
      },
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: index % 2 == 0 ? Colors.blue : Colors.green,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 100.0,
              child: Text(
                'Flutter is awesome',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        },
      ),
    ));
  }
}
