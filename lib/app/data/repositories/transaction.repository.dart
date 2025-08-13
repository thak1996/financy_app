import 'package:financy_app/app/data/models/repository.model.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

abstract class TransactionRepository {
  AsyncResult<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  AsyncResult<List<TransactionModel>> getAllTransactions() async {
    await Future.delayed(Duration(seconds: 1));
    return Success([
      TransactionModel(
        title: 'Transaction 1',
        value: 100.0,
        date: DateTime.now().millisecondsSinceEpoch,
        icon: Icon(Icons.access_alarm_outlined),
      ),
      TransactionModel(
        title: 'Transaction 2',
        value: 200.0,
        date: DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch,
        icon: Icon(Icons.monetization_on_outlined),
      ),
      TransactionModel(
        title: 'Transaction 3',
        value: -300.0,
        date:
            DateTime.now().subtract(Duration(days: 14)).millisecondsSinceEpoch,
        icon: Icon(Icons.ac_unit),
      ),
    ]);
  }
}
