import 'package:chopper/chopper.dart';
import 'package:wts_customer/util/static_key.dart';

import 'utils/httpinterceptor.dart';

part 'installitiondue_api_service.chopper.dart';


//flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflic
// ting-outputs
@ChopperApi()
abstract class InstallitiondueApiService extends ChopperService{

  @Post(path: '/api/installation_dues')
  Future<Response> installation_dues(
      @Body() Map<String,dynamic> body);

  static InstallitiondueApiService create() {
    final ChopperClient? client = ChopperClient(
      baseUrl:  Uri.parse(StaticKey.BASE_URL),
      services: [
        _$InstallitiondueApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor(),HeaderInterceptor()],
    );
    return _$InstallitiondueApiService(client);
  }

}