import 'package:chopper/chopper.dart';
import 'package:wts_customer/util/static_key.dart';

import 'utils/httpinterceptor.dart';

part 'product_api_service.chopper.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
//flutter pub run build_runner build

@ChopperApi()
abstract class ProductApiService extends ChopperService{

  @Post(path: '/api/products')
  Future<Response> products(
      @Body() Map<String,dynamic> body);

  @Post(path: '/api/preparation_done')
  Future<Response> submitPreparetion(
      @Body() Map<String,dynamic> body);

  static ProductApiService create() {
    final ChopperClient? client = ChopperClient(
      baseUrl:  Uri.parse(StaticKey.BASE_URL),
      services: [
        _$ProductApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor(),HeaderInterceptor()],
    );
    return _$ProductApiService(client);
  }

}