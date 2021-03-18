class _PrismaMigration {
  int nodeId;
  String id;
  String checksum;
  DateTime finishedAt;
  String migrationName;
  String logs;
  DateTime rolledBackAt;
  DateTime startedAt;
  int appliedStepsCount;
  _PrismaMigration(
      {this.nodeId,
      this.id,
      this.checksum,
      this.finishedAt,
      this.migrationName,
      this.logs,
      this.rolledBackAt,
      this.startedAt,
      this.appliedStepsCount});

  _PrismaMigration.fromJson(Map<String, dynamic> json) {
    nodeId = json['nodeId'];
    id = json['id'];
    checksum = json['checksum'];
    finishedAt =
        json['finishedAt'] != null ? DateTime.parse(json['finishedAt']) : null;
    migrationName = json['migrationName'];
    logs = json['logs'];
    rolledBackAt = json['rolledBackAt'] != null
        ? DateTime.parse(json['rolledBackAt'])
        : null;
    startedAt =
        json['startedAt'] != null ? DateTime.parse(json['startedAt']) : null;
    appliedStepsCount = json['appliedStepsCount'];
  }

  Map toJson() {
    Map data = {};
    data['nodeId'] = nodeId;
    data['id'] = id;
    data['checksum'] = checksum;
    data['finishedAt'] = finishedAt?.toString();
    data['migrationName'] = migrationName;
    data['logs'] = logs;
    data['rolledBackAt'] = rolledBackAt?.toString();
    data['startedAt'] = startedAt?.toString();
    data['appliedStepsCount'] = appliedStepsCount;
    return data;
  }
}
