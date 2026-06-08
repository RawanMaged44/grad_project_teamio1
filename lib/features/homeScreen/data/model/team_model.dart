import 'package:graduation_project/core/api/api_constants.dart';

class TeamModel {
  bool? success;
  TeamData? data;

  TeamModel({this.success, this.data});

  TeamModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? TeamData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class TeamData {
  int? teamNumber;
  String? teamId;
  String? teamName;
  String? status;
  String? createAt;
  int? memberCount;
  String? leaderName;
  List<MemberModel>? members;

  TeamData({
    this.teamNumber,
    this.teamId,
    this.teamName,
    this.status,
    this.createAt,
    this.memberCount,
    this.leaderName,
    this.members,
  });

  TeamData.fromJson(Map<String, dynamic> json) {
    teamNumber = json['teamNumber'];
    teamId = json['id'] ?? json['teamId'];
    teamName = json['teamName'];
    status = json['status'];
    createAt = json['createAt'];
    memberCount = json['memberCount'];
    leaderName = json['leaderName'];
    members = json['members'] != null
        ? List<MemberModel>.from(
        json['members'].map((x) => MemberModel.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'teamNumber': teamNumber,
      'teamId': teamId,
      'teamName': teamName,
      'status': status,
      'createAt': createAt,
      'memberCount': memberCount,
      'leaderName': leaderName,
      'members': members?.map((x) => x.toJson()).toList(),
    };
  }
}

class MemberModel {
  String? id;
  String? fullName;
  String? avatarUrl;
  int? major;
  bool? isLeader;
  bool? votedForLeader;
  List<String>? skills;
  String? chatId;

  MemberModel({
    this.id,
    this.fullName,
    this.avatarUrl,
    this.major,
    this.isLeader,
    this.votedForLeader,
    this.skills,
    this.chatId,
  });

  MemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    avatarUrl = ApiConstants.buildImageUrl(json['avatarUrl']);
    major = json['major'];
    isLeader = json['isLeader'];
    votedForLeader = json['votedForLeader'];
    skills = List<String>.from(json['skills'] ?? []);
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'avatarUrl': avatarUrl,
      'major': major,
      'isLeader': isLeader,
      'votedForLeader': votedForLeader,
      'skills': skills,
      'chatId': chatId,
    };
  }
}