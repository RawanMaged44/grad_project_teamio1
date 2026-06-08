class ProfileModel {
  ProfileModel({
      this.success, 
      this.data, 
      this.errors, 
      this.statusCode,});

  ProfileModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'];
    statusCode = json['statusCode'];
  }
  bool? success;
  Data? data;
  dynamic errors;
  int? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['errors'] = errors;
    map['statusCode'] = statusCode;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.fullName, 
      this.avatarUrl, 
      this.email, 
      this.graduationYear, 
      this.phoneNumber, 
      this.department, 
      this.gitHubUserName, 
      this.desiredRole, 
      this.experienceLevel, 
      this.chatId, 
      this.skills, 
      this.tasks,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['fullName'];
    avatarUrl = json['avatarUrl'];
    email = json['email'];
    graduationYear = json['graduationYear'];
    phoneNumber = json['phoneNumber'];
    department = json['department'];
    gitHubUserName = json['gitHubUserName'];
    desiredRole = json['desiredRole'];
    experienceLevel = json['experienceLevel'];
    chatId = json['chatId'];
    skills = json['skills'] != null ? json['skills'].cast<String>() : [];
    tasks = json['tasks'] != null ? List<dynamic>.from(json['tasks']) : [];
  }
  String? id;
  String? fullName;
  String? avatarUrl;
  String? email;
  int? graduationYear;
  String? phoneNumber;
  int? department;
  String? gitHubUserName;
  String? desiredRole;
  String? experienceLevel;
  dynamic chatId;
  List<String>? skills;
  List<dynamic>? tasks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['avatarUrl'] = avatarUrl;
    map['email'] = email;
    map['graduationYear'] = graduationYear;
    map['phoneNumber'] = phoneNumber;
    map['department'] = department;
    map['gitHubUserName'] = gitHubUserName;
    map['desiredRole'] = desiredRole;
    map['experienceLevel'] = experienceLevel;
    map['chatId'] = chatId;
    map['skills'] = skills;
    if (tasks != null) {
      map['tasks'] = tasks;
    }
    return map;
  }

}