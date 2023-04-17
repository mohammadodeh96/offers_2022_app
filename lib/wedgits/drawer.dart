import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offers_2022_app/screens/phone_auth.dart';
import 'package:offers_2022_app/user/profile.dart';

// ignore: must_be_immutable
class SideNav extends StatelessWidget {
  late String? phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  late String? disblyName = FirebaseAuth.instance.currentUser!.displayName;

  SideNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.grey[300],
        child: ListView(
          children: [
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FirebaseAuth.instance.currentUser == null
                      ? Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return PhoneAuthPage();
                                  }));
                                },
                                icon: const Icon(
                                  Icons.login_outlined,
                                  size: 35,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return PhoneAuthPage();
                                }));
                              },
                              child: const Text(
                                'تسجيل دخول ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Profile();
                                  }));
                                },
                                icon: const Icon(
                                  Icons.supervisor_account_outlined,
                                  size: 35,
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return Profile();
                                }));
                              },
                              child: const Text(
                                'الذهاب لصفحة المستخدم ',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FirebaseAuth.instance.currentUser != null
                          ? Text(
                              ' اهلا بك $disblyName',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            )
                          : const SizedBox(
                              height: 10,
                            ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
