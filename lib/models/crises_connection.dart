import 'package:squadup/models/crisis.dart';
import 'package:squadup/models/crises_edge.dart';
import 'package:squadup/models/page_info.dart';

class CrisesConnection {
  List<Crisis> nodes;
  List<CrisesEdge> edges;
  PageInfo pageInfo;
  int totalCount;
  CrisesConnection({this.nodes, this.edges, this.pageInfo, this.totalCount});

  CrisesConnection.fromJson(Map<String, dynamic> json) {
    nodes = json['nodes'] != null
        ? List.generate(json['nodes'].length,
            (index) => Crisis.fromJson(json['nodes'][index]))
        : null;
    edges = json['edges'] != null
        ? List.generate(json['edges'].length,
            (index) => CrisesEdge.fromJson(json['edges'][index]))
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
