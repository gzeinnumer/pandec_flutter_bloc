class UsersDetailResponse {
  int? status;
  String? title;
  String? message;
  Info? info;
  DataUsersDetail? data;

  UsersDetailResponse(
      {this.status, this.title, this.message, this.info, this.data});

  UsersDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    data = json['data'] != null ? new DataUsersDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['title'] = this.title;
    data['message'] = this.message;
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Info {
  int? total;

  Info({this.total});

  Info.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}

class DataUsersDetail {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? password;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  DataUsersDetail(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  DataUsersDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
