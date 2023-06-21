import 'package:medic_petcare/Config/Network.dart';

class EndPoint {
  static urlLogin({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      endPoint: 'login',
      body: body,
      useToken: false,
    );
  }

  static urlRegister({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      endPoint: 'register',
      body: body,
      useToken: false,
    );
  }

  static urlUser() async {
    return Network().get(
      endPoint: 'user',
    );
  }

  static updateUser({
    required Map<String, dynamic> body,
    required bool isImage,
  }) async {
    return Network().post(
      endPoint: 'user',
      header: {},
      isImage: isImage,
      body: body,
      keyFile: 'avatar',
    );
  }

  static urlAddOrder({
    required Map<String, dynamic> body,
  }) async {
    return Network().post(
      endPoint: 'order',
      header: {},
      body: body,
    );
  }

  static urlCategory() async {
    return Network().get(
      endPoint: 'categories',
    );
  }

  static urlOrder({
    String? user_id,
  }) async {
    return Network().get(
      endPoint: 'order${user_id == '' ? '' : '?user_id=$user_id'}',
    );
  }

  static urlUsers() async {
    return Network().get(
      endPoint: 'users',
    );
  }
}
