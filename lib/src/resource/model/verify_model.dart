class VerifyModel {
  final bool? status;
  final String? message;

  VerifyModel({
    this.status,
    this.message,
  });

  factory VerifyModel.fromJson(Map<String, dynamic> json) => VerifyModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
