import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:financy_app/app/shared/utils/log_printer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';

class GraphQlService {
  GraphQlService({required this.authService, String? endpoint})
    : endpoint = endpoint ?? dotenv.env['HASURA_ENDPOINT'] ?? '';

  final AuthFirebaseService authService;
  final String endpoint;
  final Logger _logger = Logger(printer: LoggerPrinter('GraphQlService'));

  GraphQLClient? _client;

  Future<GraphQLClient> getClient() async {
    if (_client != null) return _client!;
    await _initClient();
    return _client!;
  }

  Future<void> _initClient() async {
    final HttpLink httpLink = HttpLink(endpoint);

    final AuthLink authLink = AuthLink(
      getToken: () async {
        try {
          final String? token = await authService.getIdToken();
          _logger.i("$token'");
          if (token == null || token.isEmpty) return null;
          return 'Bearer $token';
        } catch (e, st) {
          _logger.e('Error getting token for GraphQL: $e', stackTrace: st);
          return null;
        }
      },
    );

    final Link link = authLink.concat(httpLink);

    _client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link,
    );
  }

  Future<void> refreshClient() async {
    _client = null;
    await _initClient();
  }
}
