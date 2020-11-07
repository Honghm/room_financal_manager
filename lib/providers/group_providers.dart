import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'file:///D:/Code/room_financal_manager/lib/models/expendituresGroup.dart';
=======
import 'file:///D:/My%20Code/Code%20Android/DoAn2/room_financal_manager/lib/models/expendituresGroup.dart';
>>>>>>> 13ff08d2dab626cf96012eed0df04ab2a8bae8f2

class GroupProviders with ChangeNotifier {
  List<ExpendituresGroup> expGroup = [];
  Future<List<ExpendituresGroup>> getExpenditures() async {
    await Firebase.initializeApp();
    try {
      await FirebaseFirestore.instance
          .collection('Groups/Penhouse/expenditures').doc('06_11_2020')
          .get()
          .then((snapshot) {
        Map<String, dynamic> data = snapshot.data();
        data["data"].forEach((key, item) {
          expGroup.add(ExpendituresGroup.fromJson(item));
          notifyListeners();
        });
      });
      return expGroup;
    }
    catch (e) {
      print(e);
    }
  }
}