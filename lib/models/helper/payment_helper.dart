import 'dart:convert';

import '../core/payment.dart';
import '../services/api_payment_service.dart';

class PaymentHelper {
  final _api = ApiPaymentService();

  Future<List<Payment>?> get() async {
    var result = await _api.get();
    if (result != null) {
      return List<Payment>.from(
          json.decode(result).map((e) => Payment.fromJson(e)));
    } else {
      print("Payment helper, get error occured");
      return null;
    }
  }

  Future<Payment?> getById(int id) async {
    var result = await _api.getById(id);
    if (result != null) {
      return Payment.fromJson(json.decode(result)[0]);
    } else {
      print("Payment helper, get by id error occurred");
      return null;
    }
  }

  Future<bool> post(Payment Payment) async {
    print("inside helper");
    return _api.post(json.encode(Payment.toJson()));
  }

  Future<bool> put(Payment newPayment) async {
    print("inside helper");
    return _api.put(json.encode(newPayment.toJson()));
  }

  Future<bool> addCard(String cardInfoCrepted, int userId) async {
    print("inside helper");

    return _api.addCard(cardInfoCrepted, userId);
  }

  Future<String?> getCard(int userId) async {
    print("inside helper");
    Map<String, dynamic> params = {"user": userId};

    var result = await _api.getCard(params);
    if (result != null) {
      return json.decode(result)[0]["card"];
    } else {
      print("get card returned a null value");
      return null;
    }
  }

  Future<bool> delete(int id) async {
    print("inside helper");
    return _api.delete(id);
  }
}
