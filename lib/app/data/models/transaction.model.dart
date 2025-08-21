// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class TransactionModel {
  final String description;
  final double value;
  final int date;

  TransactionModel({
    required this.description,
    required this.value,
    required this.date,
  });

  TransactionModel copyWith({String? description, double? value, int? date}) {
    return TransactionModel(
      description: description ?? this.description,
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'value': value,
      'date': date,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      description: map['description'] as String,
      value: double.tryParse(map['value'].toString()) ?? 0,
      date: DateTime.parse(map['date'] as String).millisecondsSinceEpoch,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TransactionModel(description: $description, value: $value, date: $date)';

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.description == description &&
        other.value == value &&
        other.date == date;
  }

  @override
  int get hashCode => description.hashCode ^ value.hashCode ^ date.hashCode;
}
