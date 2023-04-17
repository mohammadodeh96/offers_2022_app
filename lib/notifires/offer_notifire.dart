import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:offers_2022_app/models/offers.dart';

class OfferNotifier with ChangeNotifier {
  List<Offer> _offerList = [];

  late Offer _curruntOffer;

  UnmodifiableListView<Offer> get offerList => UnmodifiableListView(_offerList);

  Offer get curruntOffer => _curruntOffer;

  set offerList(List<Offer> offerList) {
    _offerList = offerList;
    notifyListeners();
  }

  set currentOffer(Offer offer) {
    _curruntOffer = offer;
    notifyListeners();
  }
}
