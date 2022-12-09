import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  //함수를 담고 있음
  return HttpConnector(); // lead 또는 watch할 때 메모리에 뜨게 됨 (최초에 안뜸!)
}); // 기존 new된걸 쓰는 싱글톤으로 유지하려고 사용함!! (* 필요할때마다 필요한곳에서 new해서 써도 됨)

class HttpConnector {
  final host = "http://localhost:8080";
  final headers = {"Content-Type": "application/json; charset=utf-8"};
  final Client _client = Client();

  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.get(uri);
    return response;
  }

  Future<Response> delete(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.delete(uri);
    return response;
  }

  Future<Response> put(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.put(uri, body: body, headers: headers);
    return response;
  }

  Future<Response> post(String path, String body) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.post(uri, body: body, headers: headers);
    return response;
  }
}
