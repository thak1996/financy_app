import 'package:flutter/material.dart';

class TransactionModel {
  final String title;
  final double value;
  final int date;
  final Icon icon;

  TransactionModel({
    required this.title,
    required this.value,
    required this.date,
    required this.icon,
  });
}
