class CommonQuestionResponse {
  List<CommonQuestions>? commonQuestions;

  CommonQuestionResponse({this.commonQuestions});

  CommonQuestionResponse.fromJson(Map<String, dynamic> json) {
    if (json['common_questions'] != null) {
      commonQuestions = <CommonQuestions>[];
      json['common_questions'].forEach((v) {
        commonQuestions!.add(new CommonQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonQuestions != null) {
      data['common_questions'] =
          this.commonQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonQuestions {
  String? sType;
  String? title;
  String? content;

  CommonQuestions({this.sType, this.title, this.content});

  CommonQuestions.fromJson(Map<String, dynamic> json) {
    sType = json['_type'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_type'] = this.sType;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
