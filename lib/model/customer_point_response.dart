class CustomerPointResponse {
  int? points;
  String? worth;
  String? expiry;

  CustomerPointResponse({this.points, this.worth, this.expiry});

  CustomerPointResponse.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    worth = json['worth'];
    expiry = json['expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['worth'] = this.worth;
    data['expiry'] = this.expiry;
    return data;
  }
}
