import 'package:squadup/models/superhero.dart';
import 'package:squadup/models/superheroes_edge.dart';
import 'package:squadup/models/page_info.dart';

class SuperheroesConnection {
  List<Superhero>? nodes;
  List<SuperheroesEdge>? edges;
  PageInfo? pageInfo;
  int? totalCount;
  SuperheroesConnection(
      {this.nodes, this.edges, this.pageInfo, this.totalCount});

  SuperheroesConnection.fromJson(Map<String, dynamic> json) {
    nodes = json['nodes'] != null
        ? List.generate(json['nodes'].length,
            (index) => Superhero.fromJson(json['nodes'][index]))
        : null;
    edges = json['edges'] != null
        ? List.generate(json['edges'].length,
            (index) => SuperheroesEdge.fromJson(json['edges'][index]))
        : null;
    pageInfo =
        json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
    totalCount = json['totalCount'];
  }

  Map toJson() {
    Map data = {};
    data['nodes'] =
        List.generate(nodes?.length ?? 0, (index) => nodes![index].toJson());
    data['edges'] =
        List.generate(edges?.length ?? 0, (index) => edges![index].toJson());
    data['pageInfo'] = pageInfo?.toJson();
    data['totalCount'] = totalCount;
    return data;
  }
}
