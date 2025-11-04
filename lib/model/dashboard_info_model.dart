import 'package:json_annotation/json_annotation.dart';
import 'package:wts_customer/model/complain_info_model.dart';
import 'package:wts_customer/model/installationdue_model.dart';

part 'dashboard_info_model.g.dart';

@JsonSerializable()
class DashBoardInfoModel{

  int complain,complain_due,products,install_dues;
  String dashboard_note;
   List<InstallationDueModel>install_in_process;
   List<ComplainModel>complain_in_process;


  DashBoardInfoModel(this.complain, this.complain_due, this.products,
      this.install_dues, this.install_in_process, this.complain_in_process,this.dashboard_note);

  factory  DashBoardInfoModel.fromJson( Map<String,dynamic> json) => _$DashBoardInfoModelFromJson(json);
  Map<String,dynamic> toJson() => _$DashBoardInfoModelToJson(this);

}