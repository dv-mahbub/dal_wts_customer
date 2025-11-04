import 'package:json_annotation/json_annotation.dart';
//part 'product_info_model.g.dart';

class ProductInfoModel {
  int? id;
  String? name;
  String? model;
  String? productSerialNumber;
  dynamic productId;
  dynamic voltage;
  dynamic specification;
  dynamic qty;
  String? purchaseDate;
  dynamic warrantyAvailable;
  dynamic installedStatus;
  dynamic image;
  dynamic status;
  List<InstallationRequirements>? installationRequirements;
  List<InstallationRequirements>? spareParts;
  dynamic supportToken;
  dynamic preparationDone;
  dynamic productCode;
  dynamic warranty_note;

  ProductInfoModel(
      {this.id,
        this.name,
        this.model,
        this.productSerialNumber,
        this.productId,
        this.voltage,
        this.specification,
        this.qty,
        this.purchaseDate,
        this.warrantyAvailable,
        this.installedStatus,
        this.image,
        this.status,
        this.supportToken,
        this.preparationDone,
        this.productCode,
        this.spareParts,
        this.installationRequirements,
        this.warranty_note
      });

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    productSerialNumber = json['product_serial_number'];
    productId = json['product_id'];
    voltage = json['voltage'];
    specification = json['specification'];
    qty = json['qty'];
    purchaseDate = json['purchase_date'];
    warrantyAvailable = json['warranty_available'];
    installedStatus = json['installed_status'];
    supportToken = json['support_token'];
    preparationDone = json['preparation_done'];
    image = json['image'];
    status = json['status'];

    productCode = json['product_code'];
    if (json['installation_requirements'] != null) {
      installationRequirements = [];
      json['installation_requirements'].forEach((v) {
        installationRequirements?.add(new InstallationRequirements.fromJson(v));
      });
    }
    if (json['spare_parts'] != null) {
      spareParts = [];
      json['spare_parts'].forEach((v) {
        spareParts?.add(new InstallationRequirements.fromJson(v));
      });
    }
    warranty_note = json['warranty_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['product_serial_number'] = this.productSerialNumber;
    data['product_id'] = this.productId;
    data['voltage'] = this.voltage;
    data['specification'] = this.specification;
    data['qty'] = this.qty;
    data['purchase_date'] = this.purchaseDate;
    data['warranty_available'] = this.warrantyAvailable;
    data['installed_status'] = this.installedStatus;
    data['support_token'] = this.supportToken;
    data['preparation_done'] = this.preparationDone;
    data['image'] = this.image;
    data['status'] = this.status;
    data['product_code'] = this.productCode;
    if (this.installationRequirements != null) {
      data['installation_requirements'] =
          this.installationRequirements?.map((v) => v.toJson()).toList();
    }
    if (this.installationRequirements != null) {
      data['spare_parts'] = this.spareParts?.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class InstallationRequirements {
  String? name;
  String? description;
  bool isExpanded=false;

  InstallationRequirements({this.name,this.description});

  InstallationRequirements.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
