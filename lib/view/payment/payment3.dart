import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cool_alert/cool_alert.dart';

import '../../learn_sqlite/learn_db.dart';
import '../../learn_sqlite/models/card_details.dart';
import '../../models/core/student_course.dart';
import '../../provider/payment_provider.dart';
import '../../provider/student_course_provider.dart';
import '../../provider/unit_provider.dart';
import '../../provider/user_provider.dart';
import '../student_course_view.dart';

class Payment3 extends StatefulWidget {
  const Payment3({Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<Payment3> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool cardDetailsExists = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: LearnDatabase.learnDatabaseInstance
            .getByIdUser(Provider.of<UserProvider>(context).user.id),
        builder: (BuildContext context, AsyncSnapshot<CardDetails?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Icon(Icons.error_outline),
            );
          } else if ((!snapshot.hasData)) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else {
            // if only one is not null it means that the isEmpty constructor was used
            if (snapshot.data!.cardVerificationValue != null) {
              cardNumber = snapshot.data!.cardNumber!;
              expiryDate = snapshot.data!.expirationDate!;
              cardHolderName = snapshot.data!.nameOnCard!;
              cvvCode = snapshot.data!.cardVerificationValue.toString();
              cardDetailsExists = true;
            }
            return buildAsyncView(context);
          }
        },
      ),
    );
  }

  SafeArea buildAsyncView(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              AppLocalizations.of(context)!.cardInfo,
              style:
                  GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            obscureCardNumber: true,
            obscureCardCvv: true,
            onCreditCardWidgetChange: (CreditCardBrand) {},
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                CreditCardForm(
                  cvvValidationMessage: 'الرجاء ادخال رمز التحقق ',
                  dateValidationMessage: 'الرجاء التثبت من تاريخ الانتهاء',
                  numberValidationMessage: 'الرجاء ادخال رقم البطاقة',
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  onCreditCardModelChange: onCreditCardModelChange,
                  themeColor: Colors.blue,
                  formKey: formKey,
                  cardNumberDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:
                          cardNumber.isEmpty ? 'رقم البطاقة' : cardNumber,
                      hintText: 'xxxx xxxx xxxx xxxx'),
                  expiryDateDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText:
                          expiryDate.isEmpty ? 'تاريخ الانتهاء' : expiryDate,
                      hintText: 'xx/xx'),
                  cvvCodeDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: cvvCode.isEmpty ? ' رمز التحقق CVV' : cvvCode,
                      hintText: 'xxx'),
                  cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: cardHolderName.isEmpty
                        ? 'الاسم على البطاقة'
                        : cardHolderName,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: Colors.amber),
                    child: Text(
                      'التالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        finishPaymentOperation();
                      }
                    },
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  finishPaymentOperation() {
    if (!cardDetailsExists) {
      insertCardDetailsToLocalDB();
    }
    addCardInfo();
    // addCourse();
  }

  void insertCardDetailsToLocalDB() async {
    CardDetails cardDetails = buildCardDetails();
    bool result = await LearnDatabase.learnDatabaseInstance
        .insertCardDetails(cardDetails);
    print("result of inser card inside payment ui is $result");
  }

  CardDetails buildCardDetails() {
    CardDetails cardDetails = CardDetails(
        cardNumber: cardNumber.replaceAll(' ', ''),
        cardVerificationValue: int.parse(cvvCode),
        userId: Provider.of<UserProvider>(context, listen: false).user.id,
        expirationDate: expiryDate,
        nameOnCard: cardHolderName);
    return cardDetails;
  }

  String getCardInfo() {
    CardDetails cardDetails = buildCardDetails();
    return cardDetails.cardNumber! +
        "#" +
        cardDetails.expirationDate! +
        "#" +
        cardDetails.cardVerificationValue.toString();
  }

  void addCardInfo() async {
    bool addCardResult =
        await Provider.of<PaymentProvider>(context, listen: false).addCard(
            Provider.of<UserProvider>(context, listen: false).user.id,
            getCardInfo());
    if (addCardResult) {
      print("add card info ui is successful");
      addCourse();
    } else {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: AppLocalizations.of(context)!.failedOperation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }

  void addCourse() async {
    StudentCourse studentCourse = StudentCourse(
        idStudent: Provider.of<UserProvider>(context, listen: false).user.id,
        idCourse: Provider.of<UnitProvider>(context, listen: false).idCourse!,
        mydate: DateTime.now(),
        status: 0,
        active: 0);

    bool result =
        await Provider.of<StudentCourseProvider>(context, listen: false)
            .postStudentCourse(studentCourse);
    if (result) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: AppLocalizations.of(context)!.operationSuccess,
        loopAnimation: true,
        confirmBtnText: AppLocalizations.of(context)!.back,
        onConfirmBtnTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => StudentCourseView())),
      );
    } else {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg: AppLocalizations.of(context)!.failedOperation,
          backgroundColor: Theme.of(context).colorScheme.primary,
          fontSize: 16);
    }
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
