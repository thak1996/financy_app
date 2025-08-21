import 'package:financy_app/app/data/exception/app.exception.dart';
import 'package:financy_app/app/data/models/transaction.model.dart';
import 'package:financy_app/app/data/services/graphql.service.dart';
import 'package:financy_app/app/shared/consts/queries/get_all_transactions.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:result_dart/result_dart.dart';

abstract class TransactionRepository {
  AsyncResult<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required this.graphQlService});

  final GraphQlService graphQlService;

  @override
  AsyncResult<List<TransactionModel>> getAllTransactions() async {
    try {
      final client = await graphQlService.getClient();
      final options = QueryOptions(
        document: gql(queryGetAllTransactions),
        fetchPolicy: FetchPolicy.networkOnly,
      );
      final result = await client.query(options);
      final parsedData = List.from(result.data?['transaction'] ?? []);
      final transactions = parsedData.map((e) => TransactionModel.fromMap(e)).toList();
      return Success(transactions);
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }
}
