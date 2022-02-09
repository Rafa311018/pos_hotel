class UserEntity {
  UserEntity({
    this.userName,
    this.password,
    this.deviceID,
  });

  String? userName;
  String? password;
  String? deviceID;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        userName: json["UserName"],
        password: json["Password"],
        deviceID: json["DeviceID"],
      );

  Map<String, dynamic> toJson() => {
        "UserName": userName,
        "Password": password,
        "DeviceID": deviceID,
      };
}
