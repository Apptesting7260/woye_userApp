
class UpdateprofileModel {
  bool? status;
  String? message;
  int? step;

  UpdateprofileModel({
    this.status,
    this.message,
    this.step,
  });

  factory UpdateprofileModel.fromJson(Map<String, dynamic> json) => UpdateprofileModel(
    status: json["status"],
    message: json["message"],
    step: json["step"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "step": step,
  };
}
