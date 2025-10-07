import 'package:financy_app/app/data/exception/app.exception.dart';
import 'package:financy_app/app/data/models/balances.model.dart';
import 'package:financy_app/app/data/models/transaction.model.dart';
import 'package:financy_app/app/data/services/graphql.service.dart';
import 'package:financy_app/app/shared/consts/queries/get_all_transactions.dart';
import 'package:financy_app/app/shared/consts/queries/get_balances.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:result_dart/result_dart.dart';

abstract class TransactionRepository {
  AsyncResult<void> addTransaction();
  AsyncResult<List<TransactionModel>> getAllTransactions();
  AsyncResult<BalancesModel> getBalances();
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
      if (result.hasException) throw result.exception!;
      final parsedData = List.from(result.data?['transaction'] ?? []);
      final transactions =
          parsedData.map((e) => TransactionModel.fromMap(e)).toList();
      return Success(transactions);
    } on OperationException catch (e, s) {
      return Failure(
        AppException(
          message:
              e.graphqlErrors.isNotEmpty
                  ? e.graphqlErrors.first.message
                  : 'Erro na comunicação com o servidor.',
          originalException: e,
          stackTrace: s,
        ),
      );
    } catch (e, s) {
      return Failure(
        AppException(
          message: 'Ocorreu um erro inesperado. Verifique sua conexão.',
          originalException: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        ),
      );
    }
  }

  @override
  AsyncResult<void> addTransaction() {
    throw UnimplementedError();
  }

  @override
  AsyncResult<BalancesModel> getBalances() async {
    try {
      final client = await graphQlService.getClient();
      final options = QueryOptions(
        document: gql(queryGetBalances),
        fetchPolicy: FetchPolicy.networkOnly,
      );
      final result = await client.query(options);
      if (result.hasException) throw result.exception!;
      final parsedData = result.data?['balances'] ?? {};
      final balances = BalancesModel.fromMap(parsedData);
      return Success(balances);
    } on OperationException catch (e, s) {
      return Failure(
        AppException(
          message:
              e.graphqlErrors.isNotEmpty
                  ? e.graphqlErrors.first.message
                  : 'Erro na comunicação com o servidor.',
          originalException: e,
          stackTrace: s,
        ),
      );
    } catch (e, s) {
      return Failure(
        AppException(
          message: 'Ocorreu um erro inesperado. Verifique sua conexão.',
          originalException: e is Exception ? e : Exception(e.toString()),
          stackTrace: s,
        ),
      );
    }
  }
}
