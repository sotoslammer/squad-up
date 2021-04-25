import 'package:graphql/client.dart';

final crisisById = gql(r'''
  query CrisisById($id: Int!) {
    crisisById(id:$id) {
      id
      name
      threat
      type
      map
      setup
      scoring
      rules
    }
  }
''');