
class Password {
  String? id;
  String? userName;
  String? appName;
  String? password;
  int? icon;
  int? color;

  Password({required this.id, required this.icon, required this.color, required this.userName, required this.appName, required this.password});

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
        id : json['id'],
        appName : json['appName'],
        password : json['password'],
        userName : json['userName'],
        icon : json['icon'],
        color : json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'appName' : appName,
      'password' : password,
      'userName' : userName,
      'icon' : icon,
      'color' : color,
    };
  }
}
