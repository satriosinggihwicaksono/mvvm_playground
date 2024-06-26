import 'package:intl/intl.dart';

class HomeData {
  HomeData({
    required this.data,
  });
  late final List<Data> data;

  HomeData.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  Data({
    required this.uid,
    required this.displayName,
    required this.imageUrl,
    required this.lastMessage,
    required this.lastSent,
  });
  late final int uid;
  late final String displayName;
  late final String imageUrl;
  late final String lastMessage;
  late final String lastSent;

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['display_name'];
    imageUrl = json['image_url'];
    lastMessage = json['last_message'];
    lastSent = DateFormat('hh:mm').format(DateTime.parse(json['last_sent']));
  }
}
