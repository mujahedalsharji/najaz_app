/*
 * Najaz Mobile App
 * Service Form Query
 */

class ServiceFormQuery {
  static const String getServiceForm = '''
    query GetServiceForm(\$id: ID!) {
      citizenService(id: \$id) {
        id
        name
        description
        baseImage
        images {
          id
          type
          path
          url
          position
          serviceId
        }
        form {
          groups {
            code
            label
            description
            isNotifiable
            fields {
              code
              label
              type
              isRequired
              defaultValue
              validationRules
              options {
                value
                label
              }
            }
          }
        }
      }
    }
  ''';
}

