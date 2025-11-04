// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProductApiService extends ProductApiService {
  _$ProductApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProductApiService;

  @override
  Future<Response<dynamic>> products(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/products');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> submitPreparetion(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/preparation_done');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
