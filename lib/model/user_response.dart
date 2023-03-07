class UsersResponse {
  int? status;
  String? title;
  String? message;
  Info? info;
  List<DataUsers>? data;

  UsersResponse({this.status, this.title, this.message, this.info, this.data});

  UsersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    message = json['message'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['data'] != null) {
      data = <DataUsers>[];
      json['data'].forEach((v) {
        data!.add(new DataUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['title'] = title;
    data['message'] = message;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
    data['total'] = total;
    return data;
  }
}

class DataUsers {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  String? password;
  Null? rememberToken;
  String? createdAt;
  String? updatedAt;

  DataUsers(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.rememberToken,
        this.createdAt,
        this.updatedAt});

  DataUsers.fromJson(Map<String, dynamic> json) {
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
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String toJsonCustom() {
    var res = "";
    res = "$res$id\n";
    res = "$res$name\n";
    res = "$res$email";
    // res = "$res$emailVerifiedAt\n";
    // res = "$res$password\n";
    // res = "$res$rememberToken\n";
    // res = "$res$createdAt\n";
    // res = "$res$updatedAt";
    return res;
  }
}
