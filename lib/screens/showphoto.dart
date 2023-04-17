import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:offers_2022_app/notifires/offer_notifire.dart';
import 'package:offers_2022_app/wedgits/offer_details.dart';
import 'package:provider/provider.dart';

class ShowPhotoScreen extends StatelessWidget {
  const ShowPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OfferNotifier offerNotifier = Provider.of<OfferNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900]),
      home: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
          backgroundColor: Colors.cyan[800],
          title: Center(child: Text(offerNotifier.curruntOffer.title)),
        ),
        body: Stack(children: [
          InteractiveViewer(
            child: Swiper(
              layout: SwiperLayout.STACK,
              itemWidth: MediaQuery.of(context).size.width * 0.87,
              itemHeight: MediaQuery.of(context).size.width * 1.50,
              autoplay: true,
              indicatorLayout: PageIndicatorLayout.COLOR,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  offerNotifier.curruntOffer.sliderImg[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: offerNotifier.curruntOffer.sliderImg.length,
              pagination: const SwiperPagination(),
              control: SwiperControl(
                  iconNext: Icons.fast_forward_outlined,
                  size: 60,
                  iconPrevious: Icons.fast_rewind_outlined,
                  color: Colors.greenAccent[800]),
            ),
          ),
          Container(
            height: 40,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.99),
                ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent.withOpacity(0.4)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return OfferDetailsscreen(context);
                  }));
                },
                child: Row(
                  children: const [
                    Text(
                      'معلومات العرض',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Icon(Icons.info_outline),
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
