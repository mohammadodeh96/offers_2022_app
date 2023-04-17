// ignore_for_file: prefer_function_declarations_over_variables,

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offers_2022_app/screens/offers_screen.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showAlertDialog(context: context, message: "تمت المصادقة بنجاح");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showAlertDialog(context: context, message: exception.toString());
    };

    PhoneCodeSent codeSent = (String verificationID, [int? forceResendToken]) {
      showAlertDialog(context: context, message: "تم ارسال الكوود الى الرقم");
      setData(verificationID);
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (String verificationID) {
            showSnackBar(context, 'انتهى وقت انتظار الرسالة');
          },
          timeout: const Duration(seconds: 60));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // ignore: unused_local_variable
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const OffersScreen()),
          (route) => false);

      showSnackBar(context, "logged In");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
