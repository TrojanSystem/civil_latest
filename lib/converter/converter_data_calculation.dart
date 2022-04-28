import 'package:flutter/material.dart';

class ConverterDataCalculation extends ChangeNotifier {
  List length = [
    {
      'mon': 'um',
      'day': 0,
    },
    {
      'mon': 'mm',
      'day': 1,
    },
    {
      'mon': 'cm',
      'day': 2,
    },
    {
      'mon': 'dm',
      'day': 3,
    },
    {
      'mon': 'm',
      'day': 4,
    },
    {
      'mon': 'inch',
      'day': 5,
    },
    {
      'mon': 'ft',
      'day': 6,
    },
    {
      'mon': 'ft in',
      'day': 7,
    },
    {
      'mon': 'yd',
      'day': 8,
    },
    {
      'mon': 'mile',
      'day': 9,
    },
    {
      'mon': 'km',
      'day': 10,
    },
  ];
  List area = [
    {
      'mon': 'mm',
      'day': 0,
    },
    {
      'mon': 'cm',
      'day': 1,
    },
    {
      'mon': 'dm',
      'day': 2,
    },
    {
      'mon': 'm',
      'day': 3,
    },
    {
      'mon': 'inch',
      'day': 4,
    },
    {
      'mon': 'ft',
      'day': 5,
    },
    {
      'mon': 'yd',
      'day': 6,
    },
    {
      'mon': 'ha',
      'day': 7,
    },
    {
      'mon': 'mile',
      'day': 8,
    },
    {
      'mon': 'km',
      'day': 9,
    },
    {
      'mon': 'acre',
      'day': 10,
    },
  ];
  List weight = ['um', 'mm', 'g', 'kg', 'ib', 'oz', 'tonne'];
  List volume = [
    'ml',
    'cl',
    'dl',
    'L',
    'mm',
    'cm',
    'dm',
    'm',
    'in',
    'ft',
    'yd',
    'gal'
  ];
}
