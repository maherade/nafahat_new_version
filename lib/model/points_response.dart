class PointsResponse {
  List<Status>? status;
  List<Sources>? sources;

  PointsResponse({this.status, this.sources});

  PointsResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = <Status>[];
      json['status'].forEach((v) {
        status!.add(new Status.fromJson(v));
      });
    }
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  String? label;
  int? points;
  String? value;

  Status({this.label, this.points, this.value});

  Status.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    points = json['points'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['points'] = this.points;
    data['value'] = this.value;
    return data;
  }
}

class Sources {
  String? label;
  int? points;

  Sources({this.label, this.points});

  Sources.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['points'] = this.points;
    return data;
  }
}
