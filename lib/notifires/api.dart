import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:offers_2022_app/models/offers.dart';
import 'package:offers_2022_app/notifires/offer_notifire.dart';

getOffers(OfferNotifier offerNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('offers').get();

  List<Offer> _offerlist = [];

  for (var element in snapshot.docs) {
    Offer offer = Offer.fromMap(element.data() as Map<String, dynamic>);

    _offerlist.add(offer);
  }

  offerNotifier.offerList = _offerlist;
}
