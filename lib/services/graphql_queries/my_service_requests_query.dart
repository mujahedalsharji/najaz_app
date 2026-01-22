/*
 * Najaz Mobile App
 * My Service Requests GraphQL Query
 */

class MyServiceRequestsQuery {
  static const String myServiceRequests = '''
    query myServiceRequests(\$status: ServiceRequestStatus) {
      myServiceRequests(status: \$status) {
        data {
          id
          incrementId
          serviceId
          citizenId
          status
          formData
          notes
          completedAt
          createdAt
          updatedAt
          service {
            name
          }
        }
        paginatorInfo {
          count
          currentPage
          lastPage
          total
          hasMorePages
        }
      }
    }
  ''';
}

