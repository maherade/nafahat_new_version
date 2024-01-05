class ListReviewResponse {
  List<ReviewResponse>? listReviewResponse;

  String? totalPage;

  ListReviewResponse({this.listReviewResponse, this.totalPage});

  ListReviewResponse.fromJson(json) {
    if (json != null) {
      listReviewResponse = <ReviewResponse>[];
      json.forEach((v) {
        listReviewResponse!.add(ReviewResponse.fromJson(v));
      });
    }
  }
}

class ReviewResponse {
  int? id;
  String? dateCreated;
  int? productId;
  String? productName;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;
  ReviewerAvatarUrls? reviewerAvatarUrls;

  ReviewResponse({
    this.id,
    this.dateCreated,
    this.productId,
    this.productName,
    this.status,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
    this.reviewerAvatarUrls,
  });

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    productId = json['product_id'];
    productName = json['product_name'];
    status = json['status'];
    reviewer = json['reviewer'];
    reviewerEmail = json['reviewer_email'];
    review = json['review'];
    rating = json['rating'];
    verified = json['verified'];
    reviewerAvatarUrls = json['reviewer_avatar_urls'] != null
        ? ReviewerAvatarUrls.fromJson(json['reviewer_avatar_urls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['status'] = status;
    data['reviewer'] = reviewer;
    data['reviewer_email'] = reviewerEmail;
    data['review'] = review;
    data['rating'] = rating;
    data['verified'] = verified;
    if (reviewerAvatarUrls != null) {
      data['reviewer_avatar_urls'] = reviewerAvatarUrls!.toJson();
    }
    return data;
  }
}

class ReviewerAvatarUrls {
  String? s24;
  String? s48;
  String? s96;

  ReviewerAvatarUrls({this.s24, this.s48, this.s96});

  ReviewerAvatarUrls.fromJson(Map<String, dynamic> json) {
    s24 = json['24'];
    s48 = json['48'];
    s96 = json['96'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['24'] = s24;
    data['48'] = s48;
    data['96'] = s96;
    return data;
  }
}
