import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future CreateAbook(Map<String, dynamic> BookInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Book")
        .doc(id)
        .set(BookInfoMap);
  }
}
