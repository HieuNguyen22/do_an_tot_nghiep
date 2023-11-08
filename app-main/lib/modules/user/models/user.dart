class User {
  final String? avatar;
  final String? name;
  final String? userName;
  final int? id;
  final String? email;
  final String? address;
  final String? phone;
  final String? dateOfBirth;
  User({
    this.avatar,
    this.name,
    this.userName,
    this.id,
    this.email,
    this.address,
    this.phone,
    this.dateOfBirth,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatar: json['avatar'],
      name: json['name']??"",
      userName: json['userName']??"",
      id: json['id'],
      email: json['email']??"",
      address: json['address']??"",
      phone: (json['phone']??"").toString(),
      dateOfBirth: json['date_of_birth']??"",
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": 0,
        "email": email,
        "date_of_birth": dateOfBirth,
        "address": address,
        "phone": phone,
        "roles": [
          {"id": 1, "name": "Super Admin"}
        ]
      };
}
