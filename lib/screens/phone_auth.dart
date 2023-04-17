// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offers_2022_app/services/auth_sevrvice.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

// ignore: use_key_in_widget_constructors
class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _formkey = GlobalKey<FormState>();

  int start = 59;
  bool wait = false;
  String buttonName = "ارسال";
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text(
            "تسجيل الدخول",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  textField(),
                  const SizedBox(
                    height: 5,
                  ),
                  textNameField(),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: wait
                        ? null
                        : () async {
                            {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  start = 59;
                                  wait = true;
                                  buttonName = "اعادة ارسال الرمز";
                                });
                                await authClass.verifyPhoneNumber(
                                    "+962 ${phoneController.text}",
                                    context,
                                    setData);
                              }
                            }
                          },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          buttonName,
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                        const Text(
                          "ادخل الرمز المرسل ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  otpField(),
                  const SizedBox(
                    height: 40,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "   اعادة ارسال رمز اخر خلال",
                          style: TextStyle(
                              fontSize: 16, color: Colors.yellowAccent),
                        ),
                        TextSpan(
                          text: "00:$start",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.pinkAccent),
                        ),
                        const TextSpan(
                          text: " ثانية ",
                          style: TextStyle(
                              fontSize: 16, color: Colors.yellowAccent),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    'اذا لم يصلك الرمز تاكد من رقم هاتفك',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      authClass.signInwithPhoneNumber(
                          verificationIdFinal, smsCode, context);

                      FirebaseAuth.instance.currentUser!
                          .updateDisplayName(nameController.text);
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    // ignore: unused_local_variable
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 48,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.length < 10) {
              return "ادخل رقم مكون من 10 ارقام";
            }
            if (value.isEmpty) {
              return 'ادخل رقم هاتفك من فضلك';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'ادخل رقم هاتفك',
            hintStyle: const TextStyle(color: Colors.black, fontSize: 17),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                " (+962) ",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(String verificationID) {
    setState(() {
      verificationIdFinal = verificationID;
    });
    startTimer();
  }

  Widget textNameField() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: TextFormField(
          controller: nameController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value!.length < 3) {
              return "ادخل اسم مكون من 3 احرف";
            } else if (value.contains('0')) {
              return "لا يجوز استخدام ارقام";
            } else if (value.isEmpty) {
              return 'ادخل اسمك من فضلك';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'ادخل  اسمك',
            hintStyle: const TextStyle(color: Colors.black, fontSize: 17),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          ),
        ),
      ),
    );
  }
}
