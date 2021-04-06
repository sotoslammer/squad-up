import 'package:graphql/client.dart';

final superheroById = gql(r'''
  query SuperheroById($id: Int!) {
    superheroById(id: $id) {
      id
      name
      alterEgo
      threat
      stamina
      speed
      size
      physicalD
      energyD
      mysticD
      staminaInjured
      attacksBySuperheroId {
        nodes {
          id
          name
          power
          range
          effects
          healthy
          injured
          type
          strength
        }
      }
      superPowersBySuperheroId {
        nodes {
          id
          name
          power
          healthy
          injured
          effect
          type
        }
      }
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
''');
