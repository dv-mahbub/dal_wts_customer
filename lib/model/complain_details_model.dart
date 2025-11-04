import 'package:json_annotation/json_annotation.dart';

part 'complain_details_model.g.dart';

@JsonSerializable()
class ComplainDetailsModel{

  dynamic complain_id,invoice_no;
  String? product_name,product_id,product_serial_number,brand,
      model,voltage,warranty_period,warranty_availalbe,
      service_note,installation_note,support_engineer,assigned_date
     ,purchase_date,slot,ticket_status,complete_date,image,video
     ,support_setup_note;

  ComplainDetailsModel(
      this.complain_id,
      this.invoice_no,
      this.product_name,
      this.product_id,
      this.product_serial_number,
      this.brand,
      this.model,
      this.voltage,
      this.warranty_period,
      this.warranty_availalbe,
      this.service_note,
      this.installation_note,
      this.support_engineer,
      this.assigned_date,
      this.purchase_date,
      this.slot,
      this.ticket_status,
      this.complete_date,
      this.image,
      this.video,
      this.support_setup_note);

  factory  ComplainDetailsModel.fromJson( Map<String,dynamic> json) => _$ComplainDetailsModelFromJson(json);
  Map<String,dynamic> toJson() => _$ComplainDetailsModelToJson(this);

}