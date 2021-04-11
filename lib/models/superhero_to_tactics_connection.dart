import 'package:squadup/models/page_info.dart';
import 'package:squadup/models/superhero_to_tactic.dart';

class SuperheroToTacticsConnection {
  List<SuperheroToTactic>? nodes;
  PageInfo? pageInfo;
  int? totalCount;

  SuperheroToTacticsConnection(this.nodes, this.pageInfo, this.totalCount);

  SuperheroToTacticsConnection.fromJson(Map<String, dynamic> json) {
    nodes = json['nodes'] != null
        ? List.generate(json['nodes'].length,
            (index) => SuperheroToTactic.fromJson(json['nodes'][index]))
        : null;
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    totalCount = json['totalCount'];
  }
}
