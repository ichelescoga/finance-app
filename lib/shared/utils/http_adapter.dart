import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;

class HttpAdapter {
  String apiURL = dotenv.env["API_URL"] ?? "";

  Future<http.Response> getApi(String url, Map<String, String>? headersApi) async {
    try {
      // final headers = {
      //   'Authorization':
      //       'Bearer YOUR_ACCESS_TOKEN', // Replace with your actual header value
      // };

      final response = await http.get(
        Uri.parse("$apiURL/$url"),
        headers: headersApi,
      );
      if (response.statusCode == 200 || response.statusCode == 202) {
        return response;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      throw Exception('Something went wrong');
    }
  }

  Future<http.Response> postApi(
      String url, Object body, Map<String, String>? headers) async {
    try {
      final response = await http.post(Uri.parse("$apiURL/$url"),
          body: body, headers: headers);
      return response;
    } catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong');
    }
  }
}
