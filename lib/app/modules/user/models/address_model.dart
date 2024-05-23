import 'package:hive/hive.dart';
part 'address_model.g.dart';

@HiveType(typeId: 1)
class Address {
  @HiveField(1)
  String? street;
  @HiveField(2)
  String? suite;
  @HiveField(3)
  String? city;
  @HiveField(4)
  String? zipcode;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    return data;
  }
}
