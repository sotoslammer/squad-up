import 'package:graphql/client.dart';

final _httpLink = HttpLink(
  'http://localhost:8080/graphql',
);

GraphQLClient getClient(Store apiStore) {
  return GraphQLClient(link: _httpLink, cache: GraphQLCache(store: apiStore));
}