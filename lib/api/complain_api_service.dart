import 'package:chopper/chopper.dart';
import 'package:wts_customer/util/static_key.dart';

import 'utils/httpinterceptor.dart';

part 'complain_api_service.chopper.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
//flutter pub run build_runner build

@ChopperApi()
abstract class ComplainApiService extends ChopperService{

  @Post(path: '/api/complains')
  Future<Response> complains(
      @Body() Map<String,dynamic> body);

  @Post(path: '/api/complain_details')
  Future<Response> complain_details(
      @Body() Map<String,dynamic> body);

  @Post(path: '/api/install_details')
  Future<Response> install_details(
      @Body() Map<String,dynamic> body);

  @Post(path: '/api/complain_dues')
  Future<Response> complain_dues(
      @Body() Map<String,dynamic> body);


  @Post(path: '/api/create_complain')
  Future<Response> addComplain(
      @Body() Map<String,dynamic> body);



  @Post(path: '/api/install_not_completed')
  Future<Response> install_not_completed(
      @Body() Map<String,dynamic> body);


  @Post(path: '/api/install_completed_to_customer')
  Future<Response> install_completed_to_customer(
      @Body() Map<String,dynamic> body);




  @Post(path: '/api/support_not_completed')
  Future<Response> support_not_completed(
      @Body() Map<String,dynamic> body);


  @Post(path: '/api/support_completed_to_customer')
  Future<Response> support_completed_to_customer(
      @Body() Map<String,dynamic> body);


  @Post(path: '/api/evaluation')
  Future<Response> evaluation(
      @Body() Map<String,dynamic> body);


  @Post(path: '/api/submit_evaluation')
  Future<Response> submit_evaluation(
      @Body() Map<String,dynamic> body);




  static ComplainApiService create() {
    final ChopperClient? client = ChopperClient(
      baseUrl:  Uri.parse(StaticKey.BASE_URL),
      services: [
        _$ComplainApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor(),HeaderInterceptor()],
    );
    return _$ComplainApiService(client);
  }

}