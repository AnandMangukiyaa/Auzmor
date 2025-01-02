import 'dart:convert';

import 'package:auzmor_assignment/models/models.dart';
import 'package:flutter/services.dart';

class TrainingRepository {
  Future<List<Categories> > getCategories() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final String response = await rootBundle.loadString('assets/mock_data.json');
      final data = await json.decode(response);
      List<Categories> categories = await categoryFromJson(data);
      print("categories : ${categories.length}");
      return categories;
    } catch (e) {
      return [];
    }
  }

}
