/*
 * Najaz Mobile App
 * Home Page GraphQL Query
 * 
 * This file contains the GraphQL query for home page data.
 */

class HomePageQuery {
  static const String homePage = '''
    query homePage(
      \$requestsPage: Int
      \$requestsLimit: Int
      \$servicesPage: Int
      \$servicesLimit: Int
    ) {
      homePage(
        requestsPage: \$requestsPage
        requestsLimit: \$requestsLimit
        servicesPage: \$servicesPage
        servicesLimit: \$servicesLimit
      ) {
        citizen {
          id
          firstName
          middleName
          lastName
          identityVerificationStatus
        }
        unreadNotificationsCount
        serviceRequests {
          data {
            id
            incrementId
            status
            service {
              id
              name
            }
            createdAt
          }
          paginatorInfo {
            total
            currentPage
            lastPage
            hasMorePages
          }
        }
        services {
          data {
            id
            name
            baseImage
          }
          paginatorInfo {
            total
            currentPage
            lastPage
            hasMorePages
          }
        }
      }
    }
  ''';
}

