import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:squadup/bloc/roster_builder/bloc.dart';
import 'package:squadup/bloc/roster_builder/event.dart';
import 'package:squadup/bloc/roster_builder/roster_builder.dart';
import 'package:squadup/models/crisis.dart';
import 'package:squadup/models/roster.dart';
import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/tactic.dart';
import 'package:squadup/widgets/roster_tab_navigator.dart';

import '../get_it.dart';

class BuilderScreen extends StatelessWidget {
  final builderBloc = getIt.get<RosterBuilderBloc>();

  @override
  Widget build(BuildContext context) {
    Roster roster = ModalRoute.of(context)!.settings.arguments as Roster;
    return BlocProvider(
        create: (BuildContext context) =>
            builderBloc..add(SetRoster(roster: roster)),
        child: Builder(bloc: builderBloc));
  }
}

class Builder extends StatefulWidget {
  final RosterBuilderBloc bloc;

  Builder({required this.bloc});

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
      Widget body = Container();
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

  const _Builder({required this.roster}) : super();

  @override
  State<StatefulWidget> createState() => _BuilderState(roster);
}

class _BuilderState extends State<_Builder>
    with SingleTickerProviderStateMixin {
  final tabs = [
    Tab(text: 'CHARACTERS'),
    Tab(text: 'TACTICS'),
    Tab(text: 'CRISIS'),
  ];

  late TabController _tabController =
      TabController(length: tabs.length, vsync: this);
  List cards = [];
  late final selections = [
    roster.superHeroes,
    roster.tacticCards,
    roster.crisisCards
  ];

  final nameController = TextEditingController(text: '');

  final Roster roster;

  _BuilderState(this.roster);

  @override
  void initState() {
    super.initState();
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
        itemBuilder: (BuildContext context, int index) =>
            Card(child: buildSlot(index)),
      ),
    ));
  }

  Widget buildSlot(int idx) {
    var selectedTab = _tabController.index;
    if (selectedTab == 0) {
      return CharacterSlot(hero: cards[idx]);
    } else if (selectedTab == 1) {
      return TacticSlot(tactic: cards[idx]);
    } else {
      return CrisisSlot(crisis: cards[idx]);
    }
  }
}

class CharacterSlot extends StatelessWidget {
  final Superhero? hero;

  const CharacterSlot({Key? key, this.hero}) : super(key: key);

  void gotToCharacterSelector(BuildContext context) {
    Navigator.pushNamed(context, RosterTabRoutes.characterSelector);
  }

  @override
  Widget build(BuildContext context) {
    if (hero == null) {
      return ListTile(
        title: Text('Empty'),
        onTap: () => gotToCharacterSelector(context),
      );
    }

    return ListTile(
        title: Text(hero?.name ?? '--'),
        subtitle: Text(affiliatedAsString()),
        onTap: () => gotToCharacterSelector(context));
  }

  String affiliatedAsString() {
    var affiliations = hero?.affiliationToSuperheroesByB?.nodes
            ?.map((e) => e.affiliationByA?.name) ??
        ['Unaffiliated'];

    var concat = StringBuffer();

    affiliations.forEach((s) => {concat.write('$s, ')});

    return concat.toString();
  }
}

class TacticSlot extends StatelessWidget {
  final Tactic? tactic;

  const TacticSlot({Key? key, this.tactic}) : super(key: key);

  void gotToTacticSelector(BuildContext context) {
    Navigator.pushNamed(context, RosterTabRoutes.tacticSelector);
  }

  @override
  Widget build(BuildContext context) {
    if (tactic == null) {
      return ListTile(
          title: Text('Empty'), onTap: () => gotToTacticSelector(context));
    }

    return ListTile(
      title: Text(tactic?.name ?? '--'),
      onTap: () => gotToTacticSelector(context),
    );
  }
}

class CrisisSlot extends StatelessWidget {
  final Crisis? crisis;

  const CrisisSlot({Key? key, this.crisis}) : super(key: key);

  void gotToCrisisSelector(BuildContext context) {
    Navigator.pushNamed(context, RosterTabRoutes.crisisSelector);
  }

  @override
  Widget build(BuildContext context) {
    if (crisis == null) {
      return ListTile(
        title: Text('Empty'),
        onTap: () => gotToCrisisSelector(context),
      );
    }

    return ListTile(
      title: Text(crisis?.name ?? '--'),
      onTap: () => gotToCrisisSelector(context),
    );
  }
}