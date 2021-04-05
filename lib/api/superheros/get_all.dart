import 'package:graphql/client.dart';

final allSuperHeroes = gql(r'''
  query AllSuperHeros {
    allSuperheroes {
      nodes {
        id
        name
        threat
        _affiliationToSuperheroesByB {
          nodes {
            affiliationByA {
              id
              name
            }
          }
        }
      }
    }
  }
    ''');
