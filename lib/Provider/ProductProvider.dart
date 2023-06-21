import 'package:flutter/widgets.dart';
import 'package:medic_petcare/Config/Enpoint.dart';

class ProductProvider with ChangeNotifier {
  List setOrders = [];
  List get getOrders => setOrders;
  List setCategories = [];
  List get getCategories => setCategories;
  bool setIsLoading = true;
  bool get isLoading => setIsLoading;

  Future<Map<String, dynamic>> orders(
    String? id,
  ) async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlOrder(user_id: id ?? '');
      if (response['meta']['code'] == 200) {
        setOrders = response['data'];
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

  Future<Map<String, dynamic>> categories() async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlCategory();
      if (response['meta']['code'] == 200) {
        setCategories = response['data'];
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

  Future<Map<String, dynamic>> addOrder({
    required Map<String, dynamic> body,
  }) async {
    try {
      setIsLoading = true;
      var response = await EndPoint.urlAddOrder(
        body: body,
      );
      if (response['meta']['code'] == 200) {
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
