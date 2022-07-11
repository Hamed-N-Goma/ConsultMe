import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenService {
  TokenService._();
  static final inctance = TokenService._();
  final http.Client client = http.Client();
  final tokenGeneratorUri = 'https://consultmeee.herokuapp.com/rtc/';
  Future<dynamic> createToken(channelName, role, tokenType, uid) async {
    try {
      var url = Uri.parse(tokenGeneratorUri +
          channelName +
          '/' +
          role +
          '/' +
          tokenType +
          '/' +
          uid);
      final response = await client.get(url);
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return responseMap;
    } catch (e) {
      print(e.toString());
    }
  }
}
