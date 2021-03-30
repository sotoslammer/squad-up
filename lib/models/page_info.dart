class PageInfo {
  bool? hasNextPage;
  bool? hasPreviousPage;
  var startCursor;
  var endCursor;
  PageInfo(
      {this.hasNextPage,
      this.hasPreviousPage,
      this.startCursor,
      this.endCursor});

  PageInfo.fromJson(Map<String, dynamic> json) {
    hasNextPage = json['hasNextPage'];
    hasPreviousPage = json['hasPreviousPage'];
    startCursor = json['startCursor'];
    endCursor = json['endCursor'];
  }

  Map toJson() {
    Map data = {};
    data['hasNextPage'] = hasNextPage;
    data['hasPreviousPage'] = hasPreviousPage;
    data['startCursor'] = startCursor;
    data['endCursor'] = endCursor;
    return data;
  }
}
