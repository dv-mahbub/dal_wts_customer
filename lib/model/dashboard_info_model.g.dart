// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoardInfoModel _$DashBoardInfoModelFromJson(Map<String, dynamic> json) {
  return DashBoardInfoModel(
    json['complain'] ?? 0,
    json['complain_due'] ?? 0,
    json['products'] ?? 0,
    json['install_dues'] ?? 0,
    (json['install_in_process'] as List<dynamic>)
        .map((e) => InstallationDueModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['complain_in_process'] as List<dynamic>)
        .map((e) => ComplainModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['dashboard_note'] ?? "",
  );
}

Map<String, dynamic> _$DashBoardInfoModelToJson(DashBoardInfoModel instance) =>
    <String, dynamic>{
      'complain': instance.complain,
      'complain_due': instance.complain_due,
      'products': instance.products,
      'install_dues': instance.install_dues,
      'dashboard_note': instance.dashboard_note,
      'install_in_process': instance.install_in_process,
      'complain_in_process': instance.complain_in_process,
    };
