import 'package:flutter/cupertino.dart';

import '../models/app_utilities.dart';
import '../models/core/payment.dart';
import '../models/helper/payment_helper.dart';

class PaymentProvider extends ChangeNotifier {
  final _helper = PaymentHelper();

  bool loading = false;
  List<Payment> _Payments = [];

  List<Payment> get Payments => _Payments;

  initializePayments() async {
    loading = true;
    _Payments = (await _helper.get())!;
    loading = false;
    notifyListeners();
  }

  Future<Payment> getById(int id) async {
    return (await _helper.getById(id))!;
  }

  Future<bool> postPayment(Payment payment) async {
    print("inside provider");
    return await _helper.post(payment);
  }

  Future<bool> deletePayment(int id) async {
    print("inside provider");
    return _helper.delete(id);
  }

  Future<bool> addCard(int userId, String cardInfo) async {
    print("card info currently" + cardInfo);
    bool result =
        await _helper.addCard(AppUtilities.creptCardInfo(cardInfo), userId);
    if (result) {
      print("added successfully");
      return true;
    } else {
      print("add card fail");
      return false;
    }
  }

  Future<Map<String, String>?> getCard(int userId) async {
    String? cardInfoEncrepted = await _helper.getCard(userId);
    if (cardInfoEncrepted != null) {
      print("Card info returned");
      return organizeCardInfo(cardInfoEncrepted);
    } else {
      print("Card info is null");
      return null;
    }
  }

  Map<String, String> organizeCardInfo(String cardInfoEncrepted) {
    Map<String, String> mapCardInfo = Map<String, String>();
    String cardInfo = AppUtilities.decreptCardInfo(cardInfoEncrepted);
    mapCardInfo["cardNumber"] = cardInfo.substring(0, cardInfo.indexOf("#"));
    mapCardInfo["endDate"] = cardInfo.substring(
        mapCardInfo["cardNumber"]!.length, cardInfo.indexOf("#"));
    mapCardInfo["cvv"] = cardInfo.substring(mapCardInfo["endDate"]!.length);
    return mapCardInfo;
  }
}
