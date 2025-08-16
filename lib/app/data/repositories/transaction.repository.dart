import 'package:financy_app/app/data/exception/app.exception.dart';
import 'package:financy_app/app/data/models/repository.model.dart';
import 'package:financy_app/app/data/services/graohql.service.dart';
import 'package:financy_app/app/shared/consts/queries/get_all_transactions.dart';
import 'package:financy_app/app/shared/utils/log_printer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

abstract class TransactionRepository {
  AsyncResult<List<TransactionModel>> getAllTransactions();
}

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({required this.graphQlService});

  final GraphQlService graphQlService;

  final Logger _logger = Logger(
    printer: LoggerPrinter('TransactionRepository'),
  );

  @override
  AsyncResult<List<TransactionModel>> getAllTransactions() async {
    try {
      final client = await graphQlService.getClient();

      final options = QueryOptions(
        document: gql(queryGetAllTransactions),
        fetchPolicy: FetchPolicy.networkOnly,
      );
      final result = await client.query(options);
      _logger.i('QueryResult: ${result.data.toString()}');
      return Success([]);
    } catch (e) {
      return Failure(AppException.fromStatusCode(e.hashCode, e.toString()));
    }
  }
}
