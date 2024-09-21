
import 'package:graphql_flutter/graphql_flutter.dart';

extension GraphQLExtensions on GraphQLClient {

  Future<QueryResult> perform({
    required String mutation,
    Map<String, dynamic> variables = const {}
  }) {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables,
      cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      errorPolicy: ErrorPolicy.all,
      fetchPolicy: FetchPolicy.networkOnly
    );
    return mutate(options);
  }

  Future<QueryResult> fetch({
    required String query,
    Map<String, dynamic> variables = const {}
  }) {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
      fetchPolicy: FetchPolicy.networkOnly,
      cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
      errorPolicy: ErrorPolicy.all
    );
    return this.query(options);
  }
}