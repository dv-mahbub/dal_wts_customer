// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$HomeApiService extends HomeApiService {
  _$HomeApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = HomeApiService;

  @override
  Future<Response<dynamic>> dashBoard(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/dashboard');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPromotionBanner() {
    final $url = Uri.parse('/api/promotion_banner');
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getOffers() {
    final $url = Uri.parse('/api/offers');
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> uploadProfilePic(int customer_id, String file) {
    final $url = Uri.parse('/api/changeprofilepic');
    final $parts = <PartValue>[
      PartValue<int>('customer_id', customer_id),
      PartValueFile<String>('image', file)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }
}
