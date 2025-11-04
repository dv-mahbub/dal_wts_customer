// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installitiondue_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$InstallitiondueApiService extends InstallitiondueApiService {
  _$InstallitiondueApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = InstallitiondueApiService;

  @override
  Future<Response<dynamic>> installation_dues(Map<String, dynamic> body) {
    final $url = Uri.parse('/api/installation_dues');
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
