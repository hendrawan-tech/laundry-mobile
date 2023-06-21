import 'package:flutter/widgets.dart';
import 'package:medic_petcare/Config/Enpoint.dart';
import 'package:medic_petcare/Utils/Storage.dart';
import 'package:medic_petcare/Utils/StorageKey.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> setUserData = {};
  Map<String, dynamic> get getUserData => setUserData;
  List setListUser = [];
  List get getListUser => setListUser;
  bool setIsLoading = true;
  bool get isLoading => setIsLoading;

  Future<Map<String, dynamic>> login({
    required Map<String, dynamic> body,
  }) async {
    try {
      var response = await EndPoint.urlLogin(
        body: body,
      );
      if (response['meta']['code'] == 200) {
        Storage.save(tokenStorageKey, response['data']['token']);
        setUserData = response['data']['user'];
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return {
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> register({
    required Map<String, dynamic> body,
  }) async {
    try {
      var response = await EndPoint.urlRegister(
        body: body,
      );
      if (response['meta']['code'] == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return {
        "message": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      var response = await EndPoint.urlUser();
      if (response['meta']['code'] == 200) {
        setUserData = response['data']['user'];
        notifyListeners();
        return response;
      } else {
        return {
          "meta": {
            "code": 403,
          },
        };
      }
    } catch (e) {
      return {
        "meta": {
          "code": 403,
        },
      };
    }
  }

  Future<Map<String, dynamic>> updateuser({
    required Map<String, dynamic> body,
    required bool isImage,
  }) async {
    var response = await EndPoint.updateUser(
      body: body,
      isImage: isImage,
    );
    try {
      if (response['meta']['code'] == 200) {
        return response;
      } else {
        return {
          "meta": {
            "code": 403,
          },
        };
      }
    } catch (e) {
      return {
        "meta": {
          "code": 403,
        },
      };
    }
  }

  Future<Map<String, dynamic>> users() async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlUsers();
      if (response['meta']['code'] == 200) {
        setListUser = response['data'];
        setIsLoading = false;
        notifyListeners();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      return {
        "message": e.toString(),
      };
    }
  }
}
