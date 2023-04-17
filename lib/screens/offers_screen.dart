import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:offers_2022_app/notifires/api.dart';
import 'package:offers_2022_app/notifires/offer_notifire.dart';
import 'package:offers_2022_app/screens/showphoto.dart';
import 'package:offers_2022_app/wedgits/drawer.dart';
import 'package:provider/provider.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  get child => null;

  @override
  void initState() {
    getCurruntUser();
    OfferNotifier offerNotifier =
        Provider.of<OfferNotifier>(context, listen: false);
    getOffers(offerNotifier);
    super.initState();
  }

  final _auth = FirebaseAuth.instance;
  late User signedInUser;

  void getCurruntUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    OfferNotifier offerNotifier = Provider.of<OfferNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("ar", "AE"),
      theme: ThemeData(
          fontFamily: 'ElMessiri',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline5: const TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                ),
                headline6: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'ElMessiri',
                  fontWeight: FontWeight.bold,
                ),
              ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.amber)),
      home: Scaffold(
        drawer: SideNav(),
        appBar: AppBar(
          title: const Text('offersApp'),
          centerTitle: true,
          backgroundColor: Colors.cyan[800],
        ),
        body: ListView.builder(
            itemCount: offerNotifier.offerList.length,
            itemBuilder: (context, int index) {
              return InkWell(
                  onTap: () {
                    offerNotifier.currentOffer = offerNotifier.offerList[index];
                    if (FirebaseAuth.instance.currentUser == null &&
                        offerNotifier.curruntOffer.onlyUsers == false) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ShowPhotoScreen();
                      }));
                    } else if (FirebaseAuth.instance.currentUser != null &&
                        offerNotifier.curruntOffer.onlyUsers == true) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ShowPhotoScreen();
                      }));
                    } else if (FirebaseAuth.instance.currentUser != null &&
                        offerNotifier.curruntOffer.onlyUsers == false) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ShowPhotoScreen();
                      }));
                    } else if (FirebaseAuth.instance.currentUser == null &&
                        offerNotifier.curruntOffer.onlyUsers == true) {
                      showOkAlertDialog(
                          context: context,
                          okLabel: 'حسنا',
                          useRootNavigator: true,
                          message:
                              'هذا العرض مخصص للمستخدمين\n سجل الدخول لمشاهدة العرض');
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 7,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              child: Image.network(
                                offerNotifier.offerList[index].mainImg,
                                height: 250,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              height: 250,
                              alignment: Alignment.bottomRight,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  stops: const [0.6, 1],
                                ),
                              ),
                              child: Text(
                                offerNotifier.offerList[index].title,
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            Container(
                                child:
                                    offerNotifier.offerList[index].onlyUsers ==
                                            true
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Icon(
                                              Icons.star_half,
                                              size: 30,
                                            ),
                                          )
                                        : const Padding(
                                            padding: EdgeInsets.all(1))),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.today,
                                      size: 35, color: Colors.cyanAccent),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    offerNotifier.offerList[index].startDate,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.cyanAccent,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '${offerNotifier.offerList[index].duration} DAYS ',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
