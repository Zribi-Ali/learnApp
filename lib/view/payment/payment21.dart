import 'package:flutter/material.dart';
import 'package:flutter_tap_payment/flutter_tap_payment.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../../models/core/courses.dart';
import '../../provider/user_provider.dart';

class payment21 extends StatefulWidget {
  const payment21({Key? key, required this.Price, required this.Course})
      : super(key: key);

  final int Price;
  //final UserProvider User;
  final int Course;
  //final

  @override
  _payment21State createState() => _payment21State();
}

class _payment21State extends State<payment21> {
  @override
  Widget build(BuildContext context) {
    //final myCourse = Provider.of<CoursesProvider>(context).getById(widget.Course);
    print("fullname current =" +
        Provider.of<UserProvider>(context).user.fullname);
    print("course current =${widget.Course}");
    print("Amount current =${widget.Price}");

    return Scaffold(
        appBar: AppBar(
            //title: Text(widget.title),
            ),
        body: Center(
          child: TextButton(
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => TapPayment(
                            apiKey: "sk_test_dE7RBrt3UziHF6LPswXlmeVc",
                            redirectUrl: "https://learn-sa.net/validPayment",
                            postUrl: "https://learn-sa.net",
                            paymentData: {
                              "amount": 10,
                              "currency": "SAR",
                              "threeDSecure": true,
                              "save_card": false,
                              "description": "",
                              "statement_descriptor": widget.Course,
                              "metadata": {
                                "udf1":
                                    Provider.of<UserProvider>(context).user.id,
                                "udf2": widget.Course
                              },
                              "reference": {"transaction": "", "order": ""},
                              "receipt": {"email": false, "sms": true},
                              "customer": {
                                "first_name": Provider.of<UserProvider>(context)
                                    .user
                                    .fullname,
                                "middle_name": "",
                                "last_name": "",
                                "email": Provider.of<UserProvider>(context)
                                    .user
                                    .email,
                                "phone": {
                                  "country_code": "",
                                  "number": Provider.of<UserProvider>(context)
                                      .user
                                      .tel
                                }
                              },
                              // "merchant": {"id": ""},
                              "source": {"id": "src_card"},
                              // "destinations": {
                              //   "destination": [
                              //     {"id": "480593777", "amount": 2, "currency": "KWD"},
                              //     {"id": "486374777", "amount": 3, "currency": "KWD"}
                              //   ]
                              // }
                            },
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                            }),
                      ),
                    )
                  },
              child: const Text("Make Payment with Tap")),
        ));
  }
}
