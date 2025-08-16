import 'package:financy_app/app/data/services/auth_firebase.service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlService {
  GraphQlService({required this.authService});

  final AuthFirebaseService authService;

  late GraphQLClient _client;

  GraphQLClient get client => _client;

  Future<void> init() async {
    final token = authService.userToken;
    final HttpLink httpLink = HttpLink(
      'https://your-graphql-endpoint.com/graphql',
    );

    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');

    final Link link = authLink.concat(httpLink);

    _client = GraphQLClient(link: link, cache: GraphQLCache());
  }
}
