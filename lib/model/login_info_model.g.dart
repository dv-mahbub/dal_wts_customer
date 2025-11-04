// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    json['customer_id'] ?? 0,
    json['name'] ?? "",
    json['email'] ?? "",
    json['phone'] ?? "",
    json['zone'] ?? "",
    json['address'] ?? "",
    json['image'] ?? "",
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel? instance) =>
    <String, dynamic>{
      'customer_id': instance?.customer_id ?? 0,
      'name': instance?.name ?? "",
      'email': instance?.email ?? "",
      'phone': instance?.phone ?? "",
      'zone': instance?.zone ?? "",
      'address': instance?.address ?? "",
      'image': instance?.image ?? "",
    };
