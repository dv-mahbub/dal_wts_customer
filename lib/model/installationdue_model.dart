import 'package:json_annotation/json_annotation.dart';

//part 'installationdue_model.g.dart';


class InstallationDueModel {
  int? complainId;
  dynamic invoiceNo;
  String? purchaseDate;
  dynamic ticketNo;
  String? model;
  String? itemId;
  dynamic? productSerialNumber;
  dynamic? voltage;
  dynamic? specification;
  String? product;
  dynamic quantity;
  String? status;
  dynamic? warrantyAvailable;
  dynamic? supportEngineer;
  dynamic? scheduleDate;
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

  InstallationDueModel({
    this.complainId,
    this.invoiceNo,
    this.purchaseDate,
    this.ticketNo,
    this.model,
    this.itemId,
    this.productSerialNumber,
    this.voltage,
    this.specification,
    this.product,
    this.quantity,
    this.status,
    this.warrantyAvailable,
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

  InstallationDueModel.fromJson(Map<String, dynamic> json) {
    complainId = json['complain_id'];
    invoiceNo = json['invoice_no'];
    purchaseDate = json['purchase_date'];
    ticketNo = json['ticket_no'];
    model = json['model'];
    itemId = json['item_id'];
    productSerialNumber = json['product_serial_number'];
    voltage = json['voltage'];
    specification = json['specification'];
    product = json['product'];
    quantity = json['quantity'];
    status = json['status'];
    warrantyAvailable = json['warranty_available'];
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
    data['purchase_date'] = this.purchaseDate;
    data['ticket_no'] = this.ticketNo;
    data['model'] = this.model;
    data['item_id'] = this.itemId;
    data['product_serial_number'] = this.productSerialNumber;
    data['voltage'] = this.voltage;
    data['specification'] = this.specification;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['warranty_available'] = this.warrantyAvailable;
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