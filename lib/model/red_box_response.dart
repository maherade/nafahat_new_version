class RedBoxResponse {
  bool? success;
  List<Points>? points;

  RedBoxResponse({this.success, this.points});

  RedBoxResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (points != null) {
      data['points'] = points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  String? id;
  String? pointName;
  String? hostNameEn;
  String? hostNameAr;
  String? locationType;
  String? description;
  String? icon;
  Location? location;
  List<String>? thumbs;
  bool? indoor;
  String? industry;
  List<Lockers>? lockers;
  List<Stores>? stores;
  Address? address;
  String? openHour;
  OpenHourData? openHourData;
  List<DataOpenHours>? dataOpenHours;
  String? status;
  bool? isPublic;
  AlertMessage? alertMessage;
  AlertMessage? city;
  bool? isFull;
  double? distance;
  String? typePoint;
  int? estimateTime;
  String? estimateTimeLabel;

  Points({
    this.id,
    this.pointName,
    this.hostNameEn,
    this.hostNameAr,
    this.locationType,
    this.description,
    this.icon,
    this.location,
    this.thumbs,
    this.indoor,
    this.industry,
    this.lockers,
    this.stores,
    this.address,
    this.openHour,
    this.openHourData,
    this.dataOpenHours,
    this.status,
    this.isPublic,
    this.alertMessage,
    this.city,
    this.isFull,
    this.distance,
    this.typePoint,
    this.estimateTime,
    this.estimateTimeLabel,
  });

  Points.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pointName = json['point_name'];
    hostNameEn = json['host_name_en'];
    hostNameAr = json['host_name_ar'];
    locationType = json['location_type'];
    description = json['description'];
    icon = json['icon'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    thumbs = json['thumbs'].cast<String>();
    indoor = json['indoor'];
    industry = json['industry'];
    if (json['lockers'] != null) {
      lockers = <Lockers>[];
      json['lockers'].forEach((v) {
        lockers!.add(Lockers.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    openHour = json['open_hour'];
    openHourData = json['open_hour_data'] != null
        ? OpenHourData.fromJson(json['open_hour_data'])
        : null;
    if (json['data_open_hours'] != null) {
      dataOpenHours = <DataOpenHours>[];
      json['data_open_hours'].forEach((v) {
        dataOpenHours!.add(DataOpenHours.fromJson(v));
      });
    }
    status = json['status'];
    isPublic = json['is_public'];
    alertMessage = json['alert_message'] != null
        ? AlertMessage.fromJson(json['alert_message'])
        : null;
    city = json['city'] != null ? AlertMessage.fromJson(json['city']) : null;
    isFull = json['is_full'];
    distance = json['distance'];
    typePoint = json['type_point'];
    estimateTime = json['estimate_time'];
    estimateTimeLabel = json['estimate_time_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['point_name'] = pointName;
    data['host_name_en'] = hostNameEn;
    data['host_name_ar'] = hostNameAr;
    data['location_type'] = locationType;
    data['description'] = description;
    data['icon'] = icon;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['thumbs'] = thumbs;
    data['indoor'] = indoor;
    data['industry'] = industry;
    if (lockers != null) {
      data['lockers'] = lockers!.map((v) => v.toJson()).toList();
    }
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['open_hour'] = openHour;
    if (openHourData != null) {
      data['open_hour_data'] = openHourData!.toJson();
    }
    if (dataOpenHours != null) {
      data['data_open_hours'] = dataOpenHours!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['is_public'] = isPublic;
    if (alertMessage != null) {
      data['alert_message'] = alertMessage!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['is_full'] = isFull;
    data['distance'] = distance;
    data['type_point'] = typePoint;
    data['estimate_time'] = estimateTime;
    data['estimate_time_label'] = estimateTimeLabel;
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Lockers {
  String? id;
  String? name;
  String? status;
  bool? isFull;

  Lockers({this.id, this.name, this.status, this.isFull});

  Lockers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    isFull = json['is_full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['is_full'] = isFull;
    return data;
  }
}

class Stores {
  String? id;
  String? name;
  String? status;
  bool? acceptPayment;
  String? counterType;

  Stores({
    this.id,
    this.name,
    this.status,
    this.acceptPayment,
    this.counterType,
  });

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    acceptPayment = json['accept_payment'];
    counterType = json['counter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['accept_payment'] = acceptPayment;
    data['counter_type'] = counterType;
    return data;
  }
}

class Address {
  String? city;
  String? district;
  String? street;
  String? postCode;

  Address({this.city, this.district, this.street, this.postCode});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    district = json['district'];
    street = json['street'];
    postCode = json['postCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['district'] = district;
    data['street'] = street;
    data['postCode'] = postCode;
    return data;
  }
}

class OpenHourData {
  String? status;
  String? closeAt;
  String? openAt;

  OpenHourData({this.status, this.closeAt, this.openAt});

  OpenHourData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    closeAt = json['close_at'];
    openAt = json['open_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['close_at'] = closeAt;
    data['open_at'] = openAt;
    return data;
  }
}

class DataOpenHours {
  String? name;
  int? value;
  List<String>? times;
  bool? isOpenFull;

  DataOpenHours({this.name, this.value, this.times, this.isOpenFull});

  DataOpenHours.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    times = json['times'].cast<String>();
    isOpenFull = json['isOpenFull'];
    isOpenFull = json['is_open_full'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['times'] = times;
    data['isOpenFull'] = isOpenFull;
    data['is_open_full'] = isOpenFull;
    return data;
  }
}

class AlertMessage {
  String? en;
  String? ar;

  AlertMessage({this.en, this.ar});

  AlertMessage.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    return data;
  }
}
