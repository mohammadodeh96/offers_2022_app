class Offer {
  late String id;
  late String title;
  late String mainImg;
  late int duration;
  late String storeLocation;
  late List offerInfo;
  late List sliderImg;
  late String startDate;
  late bool onlyUsers;

  Offer.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    mainImg = data['mainImg'];
    title = data['title'];
    duration = data['duration'];
    storeLocation = data['storeLocation'];
    offerInfo = data['offerInfo'];
    sliderImg = data['sliderImg'];
    startDate = data['startDate'];
    onlyUsers = data['onlyUsers'];
  }
}
