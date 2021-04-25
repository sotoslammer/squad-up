import 'package:graphql/client.dart';

final allCrises = gql(r'''
  query AllCrisisCards {
    allCrises {
      nodes {
        id
        name
        type
        threat
      }
    }
  }
''');
