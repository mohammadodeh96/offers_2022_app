import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:offers_2022_app/notifires/api.dart';
import 'package:offers_2022_app/notifires/offer_notifire.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDetailsscreen extends StatefulWidget {
  static const screenRoute = '/offersDetailsScreen';
  const OfferDetailsscreen(BuildContext context, {Key? key}) : super(key: key);

  @override
  _OfferDetailsscreenState createState() => _OfferDetailsscreenState();
}

class _OfferDetailsscreenState extends State<OfferDetailsscreen> {
  @override
  void initState() {
    OfferNotifier offerNotifier =
        Provider.of<OfferNotifier>(context, listen: false);
    getOffers(offerNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OfferNotifier offerNotifier = Provider.of<OfferNotifier>(context);

    return ShowDetailsSheet(offerNotifier: offerNotifier);
  }
}

class ShowDetailsSheet extends StatelessWidget {
  const ShowDetailsSheet({
    Key? key,
    required this.offerNotifier,
  }) : super(key: key);

  final OfferNotifier offerNotifier;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: const Locale("fa", "IR"),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[800],
          title: Text(offerNotifier.curruntOffer.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSectionTitle(context, 'معلومات العرض والمتجر'),
                Image.network(offerNotifier.curruntOffer.mainImg),
                buildListViewContainer(
                  ListView.builder(
                    itemCount: offerNotifier.curruntOffer.offerInfo.length,
                    itemBuilder: (ctx, index) => Card(
                      elevation: 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child:
                            Text(offerNotifier.curruntOffer.offerInfo[index]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'للحصول على موقع المتجر',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        launch(offerNotifier.curruntOffer.storeLocation);
                      },
                      icon: const Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    const Icon(
                      Icons.touch_app_rounded,
                      size: 20,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

buildListViewContainer(Widget child) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    height: 200,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: child,
  );
}

buildSectionTitle(BuildContext context, String titleText) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    alignment: Alignment.topRight,
    child: Text(
      titleText,
      style: Theme.of(context).textTheme.headline5,
    ),
  );
}
