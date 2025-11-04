// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complain_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplainDetailsModel _$ComplainDetailsModelFromJson(Map<String, dynamic> json) {
  return ComplainDetailsModel(
    json['complain_id'],
    json['invoice_no'],
    json['product_name'] ?? "",
    json['product_id'] ?? "",
    json['product_serial_number'] ?? "",
    json['brand'] ?? "",
    json['model'] ?? "",
    json['voltage'] ?? "",
    json['warranty_period'] ?? "",
    json['warranty_availalbe'] ?? "",
    json['service_note'] ?? "",
    json['installation_note'] ?? "",
    json['support_engineer'] ?? "",
    json['assigned_date'] ?? "",
    json['purchase_date'] ?? "",
    json['slot'] ?? "",
    json['ticket_status'] ?? "",
    json['complete_date'] ?? "",
    json['image'] ?? "",
    json['video'] ?? "",
    json['support_setup_note'] ?? "",
  );
}

Map<String, dynamic> _$ComplainDetailsModelToJson(
        ComplainDetailsModel instance) =>
    <String, dynamic>{
      'complain_id': instance.complain_id,
      'invoice_no': instance.invoice_no,
      'product_name': instance.product_name,
      'product_id': instance.product_id,
      'product_serial_number': instance.product_serial_number,
      'brand': instance.brand,
      'model': instance.model,
      'voltage': instance.voltage,
      'warranty_period': instance.warranty_period,
      'warranty_availalbe': instance.warranty_availalbe,
      'service_note': instance.service_note,
      'installation_note': instance.installation_note,
      'support_engineer': instance.support_engineer,
      'assigned_date': instance.assigned_date,
      'purchase_date': instance.purchase_date,
      'slot': instance.slot,
      'ticket_status': instance.ticket_status,
      'complete_date': instance.complete_date,
      'image': instance.image,
      'video': instance.video,
      'support_setup_note': instance.support_setup_note,
    };
