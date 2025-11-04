import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:wts_customer/util/static_key.dart';

import 'utils/httpinterceptor.dart';

part 'home_api_service.chopper.dart';

//flutter pub run build_runner build

// flutter pub run build_runner build --delete-conflicting-outputs

@ChopperApi()
abstract class HomeApiService extends ChopperService {
  @Post(path: '/api/dashboard')
  Future<Response> dashBoard(@Body() Map<String, dynamic> body);

  @Get(path: "/api/promotion_banner")
  Future<Response> getPromotionBanner();

  @Get(path: "/api/offers")
  Future<Response> getOffers();

  @Post(path: '/api/changeprofilepic')
  @multipart
  Future<Response> uploadProfilePic(
      @Part("customer_id") int customer_id, @PartFile('image') String file);

  static HomeApiService create() {
    final ChopperClient? client = ChopperClient(
      baseUrl:  Uri.parse(StaticKey.BASE_URL),
      services: [
        _$HomeApiService(),
      ],
      converter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor(), HeaderInterceptor()],
    );
    return _$HomeApiService(client);
  }
}
