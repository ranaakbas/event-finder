import 'package:akbas_bas_eventfinderapp/home.dart';
import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/profile.dart';
import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';
import 'package:akbas_bas_eventfinderapp/verifycode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/art.dart';
import 'package:akbas_bas_eventfinderapp/sport.dart';
import 'package:akbas_bas_eventfinderapp/education&more.dart';
import 'package:flutter/foundation.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akbas_bas_eventfinderapp/cinema.dart';
import 'package:akbas_bas_eventfinderapp/theatre.dart';
import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:akbas_bas_eventfinderapp/verifycode.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({required this.ticketCount, this.price, this.discount});

  final ticketCount;
  final price;
  final discount;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController cardNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool hasError = false; // Track the error status
  EmailOTP myauth = EmailOTP();

  @override
  get totalPayment => widget.ticketCount * widget.price;

  get discountPayment => widget.ticketCount * widget.discount;
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF70B0C5),
                                      Color(0xFF7ACE8C),
                                      Color(0xFFCBBC66),
                                    ],
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 125,
                              ),
                              Text(
                                "Payment",
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Color(0xFF0A1034),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              userEmail != null &&
                                      userEmail!.contains("@") &&
                                      userEmail!
                                          .split("@")[1]
                                          .toLowerCase()
                                          .contains("edu.tr")
                                  ? Text(
                                      '$discountPayment ₺',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      '$totalPayment ₺',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Full Name",
                                    prefixIcon:
                                        Icon(Icons.person_outline_sharp),
                                    suffixIcon: hasError
                                        ? Icon(
                                            Icons.priority_high_rounded,
                                            color: Colors.red,
                                          )
                                        : null,
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF0A1034),
                                  ),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      setState(() {
                                        hasError = true; // Set error status
                                      });
                                      return null;
                                    }
                                    setState(() {
                                      hasError = false; // Reset error status
                                    });
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      setState(() {
                                        hasError = true; // Set error status
                                      });
                                      return null;
                                    }
                                    setState(() {
                                      hasError = false; // Reset error status
                                    });
                                    return null;
                                  },
                                  controller: cardNumberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(16),
                                    CardNumberInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Card Number",
                                    prefixIcon: Icon(Icons.credit_card),
                                    suffixIcon: hasError
                                        ? Icon(
                                            Icons.priority_high_rounded,
                                            color: Colors.red,
                                          )
                                        : null,
                                  ),
                                  style: TextStyle(
                                    color: Color(0xFF0A1034),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                          CardNumberInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "CVV",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child:
                                                Icon(Icons.calendar_view_day),
                                          ),
                                          suffixIcon: hasError
                                              ? Icon(
                                                  Icons.priority_high_rounded,
                                                  color: Colors.red,
                                                )
                                              : null,
                                        ),
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            setState(() {
                                              hasError =
                                                  true; // Set error status
                                            });
                                            return null;
                                          }
                                          setState(() {
                                            hasError =
                                                false; // Reset error status
                                          });
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardNumberInputFormatter(),
                                          CardMonthInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "MM/YY",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Icon(Icons.calendar_today),
                                          ),
                                          suffixIcon: hasError
                                              ? Icon(
                                                  Icons.priority_high_rounded,
                                                  color: Colors.red,
                                                )
                                              : null,
                                        ),
                                        validator: (value) {
                                          if (value?.isEmpty ?? true) {
                                            setState(() {
                                              hasError =
                                                  true; // Set error status
                                            });
                                            return null;
                                          }
                                          setState(() {
                                            hasError =
                                                false; // Reset error status
                                          });
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      myauth.setConfig(
                                        appEmail: "contact@hdevcoder.com",
                                        userEmail: FirebaseAuth
                                            .instance.currentUser?.email,
                                        otpLength: 4,
                                        otpType: OTPType.digitsOnly,
                                      );
                                      bool otpSent = await myauth.sendOTP();
                                      if (otpSent && hasError == false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Code sent to your mail."),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OtpScreen(
                                              myauth: myauth,
                                            ),
                                          ),
                                        );
                                      } else if (hasError == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Please fill in all fields."),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content:
                                                Text("Sign in to buy tickets."),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    backgroundColor: Color(0xFF70B0C5),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 60),
                                    child: Text(
                                      "Pay",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBackHome(
    {required IconData backHome,
    required Widget widget,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Column(
      children: [
        SizedBox(height: 29),
        Icon(
          backHome,
          color: Colors.black,
          size: 50,
        ),
      ],
    ),
  );
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (var i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
