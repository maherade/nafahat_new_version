class ListCountriesResponse {
  List<CountriesResponse>? listCountriesResponse;

  ListCountriesResponse({this.listCountriesResponse});

  ListCountriesResponse.fromJson(json) {
    if (json != null) {
      listCountriesResponse = <CountriesResponse>[];
      json.forEach((v) {
        listCountriesResponse!.add(CountriesResponse.fromJson(v));
      });
    }
  }
}

class CountriesResponse {
  dynamic code;
  dynamic name;
  List<States>? states;

  CountriesResponse({this.code, this.name, this.states});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  dynamic code;
  dynamic name;

  States({this.code, this.name});

  States.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
