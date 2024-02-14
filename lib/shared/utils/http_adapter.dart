import "dart:convert";

import "package:developer_company/global_state/providers/user_provider_state.dart";

import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/shared/routes/router_paths.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:get/get.dart";

import "package:http/http.dart" as http;

class HttpAdapter extends http.BaseClient {
  String apiURL = dotenv.env["API_URL"] ?? "";
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request);
  }

  http.Response _handleResponse(http.Response response) {
    print(
        "🚀🦔 ~ file: http_adapter.dart:22 ~ HttpAdapter ~ http.Response_handleResponse ~ response: ${response.body}");
    print(
        "🚀🤖 ~ file: http_adapter.dart:22 ~ HttpAdapter ~ http.Response_handleResponse ~ response: ${response.contentLength}");
    print(
        "🚀👁️ ~ file: http_adapter.dart:22 ~ HttpAdapter ~ http.Response_handleResponse ~ response: ${response.statusCode}");
    print(
        "🚀💧 ~ file: http_adapter.dart:22 ~ HttpAdapter ~ http.Response_handleResponse ~ response: ${response.request}");
// TODO Response always comes with message login expired please implemented here;

    if (response.statusCode == 200 || response.statusCode == 202) {
      return response;
    } else if (response.statusCode == 403) {
      Get.offAllNamed(RouterPaths.HOME_PAGE);
      EasyLoading.showInfo(Strings.sessionExpired);
      throw Exception('Login Expired');
    } else {
      print("🤖🤖🤖 ERROR IN _handleResponse 🤖🦔🦔 ${response.statusCode} ");
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> getApi(
      String url, Map<String, String>? headersApi) async {
    final user = container.read(userProviderWithoutNotifier);

    try {
      final headers = {
        'Authorization': 'Bearer ${user.jwt}',
        ...headersApi ?? {},
      };

      final response = await http.get(
        Uri.parse("$apiURL/$url"),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      print('Error GET 🗃️😭: $e');
      throw Exception('Something went wrong');
    }
  }

  Future<http.Response> getApiWithBody(
      String url, Map<String, String>? headersApi, Map<String, dynamic>? body) async {
    final user = container.read(userProviderWithoutNotifier);

    try {
      final headers = {
        'Authorization': 'Bearer ${user.jwt}',
        ...headersApi ?? {},
      };

      final jsonBody = jsonEncode(body);
      final request = http.Request('GET', Uri.parse("$apiURL/$url"));
      request.body = jsonBody;
      request.headers.addAll(headers);
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      return _handleResponse(response);
    } catch (e) {
      print('Error GET 🗃️😭: $e');
      throw Exception('Something went wrong');
    }
  }

  Future<http.Response> postApi(
      String url, Object body, Map<String, String>? headersApi) async {
    try {
      final user = container.read(userProviderWithoutNotifier);

      final headers = {
        'Authorization': 'bearer ${user.jwt}',
        ...headersApi ?? {},
      };
      print("POST BODY 😉😉 $body");
      final response = await http.post(
        Uri.parse("$apiURL/$url"),
        body: body,
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      print('Error POST $url ☝️😭: $e');
      throw Exception('Something went wrong');
    }
  }

  Future<http.Response> putApi(
      String url, Object body, Map<String, String>? headersApi) async {
    try {
      final user = container.read(userProviderWithoutNotifier);

      final headers = {
        'Authorization': 'Bearer ${user.jwt}',
        ...headersApi ?? {},
      };

      print("PUT BODY 😎😎😎 $body");
      final response = await http.put(
        Uri.parse("$apiURL/$url"),
        body: body,
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      print('Error POST 🤖😭: $e');
      throw Exception('Something went wrong');
    }
  }
}
