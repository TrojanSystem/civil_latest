import 'dart:async';

import 'package:flutter/material.dart';

class Calculation extends ChangeNotifier {
  List<String> data = [
    '  ',
    ' ',
    '  ',
    '  ',
    ' ',
    ' ',
  ];
  double water = 0;
  double cement = 0;
  double sand = 0;
  double aggregate = 0;
  double length = 0;
  double cl = 0;
  double cc = 0;
  double totNoOfBar = 0;
  double totNoOfBerga = 0;
  double dryVolume = 0;
  double bag = 0;
  double weightSand = 0;
  double weightAggregate = 0;
  double weight = 0;

  int noOfBar() {
    totNoOfBar = (length / cc) + 1;
    return totNoOfBar.floor();
  }

  void addAnswer(int ans1, int ans2) {
    data.insert(0, ans1.toString());
    data.insert(1, ans2.toString());
    notifyListeners();
  }

  void addMixRatio(String c, String s, String a, String w) {
    data.insert(2, c);
    data.insert(3, s);
    data.insert(4, a);
    data.insert(5, w);
    notifyListeners();
  }

  int noOfBerga() {
    double clPerBerga = (12 / cl);
    int clBerga = clPerBerga.floor();
    double totNoOfBerga = totNoOfBar / clBerga;
    return totNoOfBerga.floor();
  }

  double dry() {
    dryVolume = cement + aggregate + sand;
    return dryVolume;
  }

  String noOfBag() {
    double volume = (cement * 1.57) / dry();
    weight = volume * 1440;
    double bag = weight / 50;

    return bag.toStringAsFixed(2);
  }

  String weightOfSand() {
    double volume = (sand * 1.57) / dry();
    double weightSand = volume * 35.32;

    return weightSand.toStringAsFixed(2);
  }

  String weightOfAggregate() {
    double volume = (aggregate * 1.57) / dry();
    double weightAggregate = volume * 35.32;

    return weightAggregate.toStringAsFixed(2);
  }

  String litreOfWater() {
    double litre = weight * water;
    return litre.toStringAsFixed(2);
  }

}
