// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complain_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ComplainApiService extends ComplainApiService {
  _$ComplainApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ComplainApiService;

  @override
  Future<Response<dynamic>> complains(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/complains');
    final $body = body;
    final $request = Request('POST', $url , client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> complain_details(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/complain_details');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> install_details(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/install_details');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> complain_dues(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/complain_dues');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addComplain(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/create_complain');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> install_not_completed(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/install_not_completed');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> install_completed_to_customer(
      Map<String, dynamic> body) {
    final $url = Uri.parse('/api/install_completed_to_customer');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> support_not_completed(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/support_not_completed');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> support_completed_to_customer(
      Map<String, dynamic> body) {
    final $url = Uri.parse('/api/support_completed_to_customer') ;
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> evaluation(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/evaluation');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> submit_evaluation(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/submit_evaluation');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
