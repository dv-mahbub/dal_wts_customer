import 'package:json_annotation/json_annotation.dart';

part 'login_info_model.g.dart';

@JsonSerializable()
class UserInfoModel{
  int customer_id;
  String? name;
  String? email;
  String? phone;
  String? zone;
  String? address;
  String? image;


  UserInfoModel(this.customer_id, this.name, this.email, this.phone, this.zone,
      this.address, this.image){
    customer_id = customer_id;
    name = name ?? "";
    email = email ?? "";
    phone = phone ?? "";
    zone = zone ?? "";
    address = address ?? "";
    image = image ?? "";
  }

  factory  UserInfoModel.fromJson( Map<String,dynamic> json) => _$UserInfoModelFromJson(json);
  Map<String,dynamic> toJson() => _$UserInfoModelToJson(this);

}