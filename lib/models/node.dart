class Node {
  int nodeId;
  Node({this.nodeId});

  Node.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    return data;
  }
}
