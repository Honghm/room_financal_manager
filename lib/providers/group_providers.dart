import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Code/room_financal_manager/lib/models/expendituresGroup.dart';

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