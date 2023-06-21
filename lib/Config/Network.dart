import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medic_petcare/Utils/Utils.dart';
import 'package:medic_petcare/utils/Storage.dart';
import 'package:medic_petcare/utils/StorageKey.dart';

class Network {
  final String baseUrl = "https://laundry.kateruriyu.my.id";
  Map<String, String> headers = {
    'content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json'
  };
  final String codeError = "-1";

  String generateUrl(typeUrl, url) {
    return '$baseUrl/api/$url';
  }

  Future get({
    required String endPoint,
    Map<String, String>? params,
    Map<String, String>? header,
    String typeUrl = '',
  }) async {
    String url = generateUrl(typeUrl, endPoint);
    List<String> keys = [];

    if (params != null) {
      for (var mapEntry in params.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        keys.add("$key=$value");
      }

      String parameter = keys.join('&').toString();
      if (parameter.isNotEmpty) {
        url = "$url?$parameter";
      }
    }
    Map<String, String> sendHeader = {};
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;

        headers[key] = value;
      }
    }
    headers.addAll(sendHeader);

    var tokenAuth = await Storage.get(tokenStorageKey);
    if (tokenAuth != null) {
      headers['Authorization'] = "Bearer $tokenAuth";
    }

    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    var responJson = json.decode(response.body);

    try {
      if (responJson['code'].runtimeType != Null) {
        if (isResultTokenExpired(responJson['code'], responJson['message'])) {}
      }
    } catch (e) {}
    return responJson;
  }

  Future<void> post({
    required String endPoint,
    Map<String, dynamic>? body,
    List? data,
    Map<String, String>? header,
    bool useToken = true,
    bool isImage = false,
    String typeUrl = '',
    String keyFile = '',
  }) async {
    String url = generateUrl(typeUrl, endPoint);

    Map<String, String> sendHeader = {};
    Map<String, dynamic> sendBody = {};
    if (header != null) {
      for (final mapEntry in header.entries) {
        final key = mapEntry.key, value = mapEntry.value;

        headers[key] = value;
      }
      headers.addAll(sendHeader);
    }

    if (body != null) {
      for (final mapEntry in body.entries) {
        final key = mapEntry.key, value = mapEntry.value;
        sendBody[key] = value;
      }
    }
    var tokenAuth = await Storage.get(tokenStorageKey);
    if (tokenAuth.toString().isNotEmpty && useToken) {
      headers['Authorization'] = "Bearer $tokenAuth";
    }
    http.Response? response;
    if (isImage) {
      http.MultipartRequest responseMultipart =
          http.MultipartRequest('POST', Uri.parse(url));
      if (body != null) {
        for (final mapEntry in body.entries) {
          final key = mapEntry.key, value = mapEntry.value;
          responseMultipart.fields[key] = value;
        }
      }

      // if (data != null) {
      //   for (var item in data) {
      //     responseMultipart.fields['suara[]'] = item['suara'];
      //   }
      //   print(responseMultipart.fields);
      // }
      responseMultipart.files
          .add(await http.MultipartFile.fromPath(keyFile, body![keyFile]));
      responseMultipart.headers.addAll(headers);
      await responseMultipart.send().then(
            (result) => http.Response.fromStream(result).then((res) {
              if (res.statusCode == 200) {
                return response = res;
              }
              return response = res;
            }),
          );
    } else {
      response = await http.post(
        Uri.parse(url),
        body: json.encode(sendBody),
        headers: headers,
      );
    }

    try {
      var responJson = json.decode(response!.body);
      try {
        if (responJson['code'].runtimeType != Null) {
          if (isResultTokenExpired(responJson['code'], responJson['message'])) {
            // showSnackBar(
            //   navigatorKey.currentContext!,
            //   "ticketListScreen.tokenExpiredTitle",
            //   subtitle: "ticketListScreen.tokenExpired",
            //   position: "TOP",
            //   type: "danger",
            //   duration: 3,
            // );
            // navigatorKey.currentState
            //     ?.pushReplacementNamed(Navigation.loginInputScreen);
          }
        }
      } catch (e) {}
      return responJson;
    } catch (e) {
      return json.decode(
        json.encode(
          {
            // "data": response!.body,
          },
        ),
      );
    }
  }
}
