import 'package:graphql/client.dart';

final allTactics = gql(r'''
  query AllTactics{
    allTactics {
      nodes {
        id
        name
        affiliationByAffiliationId {
          name
        }
        _superheroToTacticsByB {
          nodes {
            superheroByA {
              id
              name
            }
          }
        }
      }
    }
  }
''');