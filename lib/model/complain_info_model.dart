import 'package:json_annotation/json_annotation.dart';

//part 'complain_info_model.g.dart';

class ComplainModel {
  int? complainId;
  dynamic invoiceNo;
  dynamic ticketNo;
  dynamic model;
  dynamic productId;
  dynamic productSerialNumber;
  String? itemId;
  dynamic voltage;
  dynamic specification;
  String? product;
  dynamic warrantyAvailable;
  String? serviceNote;
  String? status;
  dynamic supportEngineer;
  dynamic scheduleDate;
  String? ticketDate;
  String? createdAt;
  String? updatedAt;
  dynamic isPending;
  dynamic waitingScheduled;
  dynamic scheduled;
  dynamic onTheWay;
  dynamic toBeCompleted;
  dynamic notCompleted;
  dynamic completed;
  dynamic feedback_status;

  ComplainModel(
      {this.complainId,
        this.invoiceNo,
        this.ticketNo,
        this.model,
        this.productId,
        this.productSerialNumber,
        this.itemId,
        this.voltage,
        this.specification,
        this.product,
        this.warrantyAvailable,
        this.serviceNote,
        this.status,
        this.supportEngineer,
        this.scheduleDate,
        this.ticketDate,
        this.createdAt,
        this.updatedAt,
        this.isPending,
        this.waitingScheduled,
        this.scheduled,
        this.onTheWay,
        this.toBeCompleted,
        this.notCompleted,
        this.completed,
        this.feedback_status,
      });
  ComplainModel.fromJson(Map<String, dynamic> json) {
    complainId = json['complain_id'];
    invoiceNo = json['invoice_no'];
    ticketNo = json['ticket_no'];
    model = json['model'];
    productId = json['product_id'];
    productSerialNumber = json['product_serial_number'];
    itemId = json['item_id'];
    voltage = json['voltage'];
    specification = json['specification'];
    product = json['product'];
    warrantyAvailable = json['warranty_available'];
    serviceNote = json['service_note'];
    status = json['status'];
    supportEngineer = json['support_engineer'];
    scheduleDate = json['schedule_date'];
    ticketDate = json['ticket_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPending = json['is_pending'];
    waitingScheduled = json['waiting_scheduled'];
    scheduled = json['scheduled'];
    onTheWay = json['on_the_way'];
    toBeCompleted = json['to_be_completed'];
    notCompleted = json['not_completed'];
    completed = json['completed'];
    feedback_status = json['feedback_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complain_id'] = this.complainId;
    data['invoice_no'] = this.invoiceNo;
    data['ticket_no'] = this.ticketNo;
    data['model'] = this.model;
    data['product_id'] = this.productId;
    data['product_serial_number'] = this.productSerialNumber;
    data['item_id'] = this.itemId;
    data['voltage'] = this.voltage;
    data['specification'] = this.specification;
    data['product'] = this.product;
    data['warranty_available'] = this.warrantyAvailable;
    data['service_note'] = this.serviceNote;
    data['status'] = this.status;
    data['support_engineer'] = this.supportEngineer;
    data['schedule_date'] = this.scheduleDate;
    data['ticket_date'] = this.ticketDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_pending'] = this.isPending;
    data['waiting_scheduled'] = this.waitingScheduled;
    data['scheduled'] = this.scheduled;
    data['on_the_way'] = this.onTheWay;
    data['to_be_completed'] = this.toBeCompleted;
    data['not_completed'] = this.notCompleted;
    data['completed'] = this.completed;
    data['feedback_status'] = this.feedback_status;

    return data;
  }
}