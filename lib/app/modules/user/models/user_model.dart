import 'address_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(1)
  int? id;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? username;
  @HiveField(4)
  String? email;
  @HiveField(5)
  Address? address;
  @HiveField(6)
  String? phone;
  @HiveField(7)
  String? website;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    address =
        json['address'] != null ? Address?.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    if (address != null) {
      data['address'] = address?.toJson();
    }
    data['phone'] = phone;
    data['website'] = website;
    return data;
  }
}
