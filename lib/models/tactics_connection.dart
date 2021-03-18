import 'package:squadup/models/tactic.dart';
import 'package:squadup/models/tactics_edge.dart';
import 'package:squadup/models/page_info.dart';

class TacticsConnection {
  List<Tactic> nodes;
  List<TacticsEdge> edges;
  PageInfo pageInfo;
  int totalCount;
  TacticsConnection({this.nodes, this.edges, this.pageInfo, this.totalCount});

  TacticsConnection.fromJson(Map<String, dynamic> json) {
    nodes = json['nodes'] != null
        ? List.generate(json['nodes'].length,
            (index) => Tactic.fromJson(json['nodes'][index]))
        : null;
    edges = json['edges'] != null
        ? List.generate(json['edges'].length,
            (index) => TacticsEdge.fromJson(json['edges'][index]))
        : null;
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    totalCount = json['totalCount'];
  }

  Map toJson() {
    Map data = {};
    data['nodes'] =
        List.generate(nodes?.length ?? 0, (index) => nodes[index].toJson());
    data['edges'] =
        List.generate(edges?.length ?? 0, (index) => edges[index].toJson());
    data['pageInfo'] = pageInfo?.toJson();
    data['totalCount'] = totalCount;
    return data;
  }
}
