import 'package:graphql/client.dart';

final tacticById = gql(r'''
  query TacticById($id: Int!) {
    tacticById(id: $id) {
      id
      name
      description
      type
      affiliationByAffiliationId {
        name
      }
    }
  }
''');