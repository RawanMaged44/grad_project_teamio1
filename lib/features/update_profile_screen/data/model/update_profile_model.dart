class UpdateProfileModel {
  UpdateProfileModel({
    this.success,
    this.message,
    this.errors,
    this.statusCode,
  });

  UpdateProfileModel.fromJson(dynamic json) {
    success = json['success'];
    // backend returns success message in 'data' field as a string
    message = json['data'] is String ? json['data'] : json['message'];
    errors = json['errors'];
    statusCode = json['statusCode'];
  }

  bool? success;
  String? message;
  dynamic errors;
  int? statusCode;

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'errors': errors,
      'statusCode': statusCode,
    };
  }
}
